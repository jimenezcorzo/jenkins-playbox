#!/bin/bash
sed "s/ImageTag/$1/g" webapp.yaml > webapp.yaml
