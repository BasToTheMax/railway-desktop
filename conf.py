import yaml

with open("config.yml") as f:
    y = yaml.safe_load(f)
    y['network']['ssl']['require_ssl'] = 'false'
    print(yaml.dump(y, default_flow_style=False, sort_keys=False))
