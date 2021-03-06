/*
 *  Copyright (c) 2016 Spotify AB.
 *
 *  Licensed to the Apache Software Foundation (ASF) under one
 *  or more contributor license agreements.  See the NOTICE file
 *  distributed with this work for additional information
 *  regarding copyright ownership.  The ASF licenses this file
 *  to you under the Apache License, Version 2.0 (the
 *  "License"); you may not use this file except in compliance
 *  with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */

import Foundation
import HubFramework

/// Content operation used by the "Todo list" feature
class TodoListContentOperation: NSObject, HUBContentOperationActionPerformer, HUBContentOperationActionObserver {
    weak var delegate: HUBContentOperationDelegate?
    weak var actionPerformer: HUBActionPerformer?
    
    private var items = [String]()

    func perform(forViewURI viewURI: URL, featureInfo: HUBFeatureInfo, connectivityState: HUBConnectivityState, viewModelBuilder: HUBViewModelBuilder, previousError: Error?) {
        viewModelBuilder.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        
        items.enumerated().forEach { index, item in
            let itemRowBuilder = viewModelBuilder.builderForBodyComponentModel(withIdentifier: "item-\(index)")
            itemRowBuilder.title = item
        }
        
        delegate?.contentOperationDidFinish(self)
    }
    
    func actionPerformed(with context: HUBActionContext, featureInfo: HUBFeatureInfo, connectivityState: HUBConnectivityState) {
        guard context.customActionIdentifier == HUBIdentifier(namespace: TodoListActionFactory.namespace, name: TodoListActionNames.addCompleted) else {
            return
        }
        
        guard let itemTitle = context.customData?[TodoListAddActionCustomDataKeys.itemTitle] as? String else {
            return
        }
        
        items.append(itemTitle)
        delegate?.contentOperationRequiresRescheduling(self)
    }
    
    @objc private func handleAddButton() {
        let actionIdentifier = HUBIdentifier(namespace: TodoListActionFactory.namespace, name: TodoListActionNames.add)
        actionPerformer?.performAction(withIdentifier: actionIdentifier, customData: nil)
    }
}
