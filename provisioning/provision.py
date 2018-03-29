from PyOrgMode import PyOrgMode

def split_into_dict(lst):
    return {x[0].lower():x[1].lower() for x in map(lambda o: o.split(':'), lst)}

def sanitize_bullet_list(lst):
    return map(lambda o: o.strip(' -\n'), lst)
    
def handle_hardware(prop):
    print('Hardware:', end=' ')
    print(split_into_dict(sanitize_bullet_list(prop.content)))

def handle_os(prop):
    print('OS:', end=' ')
    print(split_into_dict(sanitize_bullet_list(prop.content)))

def handle_software(prop):
    print('Software:\n', end='')
    for sub_prop in prop.content:
        property_handler_map[sub_prop.heading.lower()](sub_prop)

def handle_sources(prop):
    print('  Sources:', end=' ')
    for sub_prop in prop.content:
        print(sub_prop.heading, end=' ')
        
def handle_packages(prop):
    print('  Packages:', end=' ')
    print(list(sanitize_bullet_list(prop.content)))

property_handler_map = {
    'hardware': handle_hardware,
    'os': handle_os,
    'software': handle_software,
    'sources': handle_sources,
    'packages': handle_packages
}

def main():
    environment = PyOrgMode.OrgDataStructure()
    environment.load_from_file('c:/dev/SideProjects/house20-admin/provisioning/sample-env.org')

    for host in environment.root.content:
        for prop in host.content:
            handler = property_handler_map[prop.heading.lower()]
            handler(prop)

if __name__ == '__main__':
    # TODO: Arguments & their parsing
    main()
