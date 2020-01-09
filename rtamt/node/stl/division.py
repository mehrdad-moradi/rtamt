# -*- coding: utf-8 -*-
"""
Created on Sun Jul 21 22:24:09 2019

@author: NickovicD
"""

from rtamt.node.stl.node import Node


class Division(Node):
    """A class for storing STL Division nodes
        Inherits Node
    """
    def __init__(self, child1, child2, is_pure_python):
        """Constructor for Division node

            Parameters:
                child1 : stl.Node
                child2 : stl.Node
        """
        super(Division, self).__init__()

        self.addChild(child1)
        self.addChild(child2)

        if is_pure_python:
            name = 'rtamt.operation.stl.division_operation'
            mod = __import__(name, fromlist=[''])
            self.node = mod.DivisionOperation()
        else:
            name = 'rtamt.lib.rtamt_stl_library_wrapper.stl_node'
            mod = __import__(name, fromlist=[''])

            name = 'rtamt.lib.rtamt_stl_library_wrapper.stl_division_node'
            mod = __import__(name, fromlist=[''])
            self.node = mod.StlDivisionNode()

