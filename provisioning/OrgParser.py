from PyOrgMode import PyOrgMode


class OrgParser:
    def __init__(self, org_file_path):
        self.hardware = None
        self.os = None
        self.packages = None
        self.sources = None
        self.software = None
        self.property_handler_map = {
            'hardware': self.handle_hardware,
            'os': self.handle_os,
            'software': self.handle_software,
            'sources': self.handle_sources,
            'packages': self.handle_packages
        }
        self.environment = PyOrgMode.OrgDataStructure()
        self.environment.load_from_file(org_file_path)

        for host in self.environment.root.content:
            for prop in host.content:
                handler = self.property_handler_map[prop.heading.lower()]
                handler(prop)

    @staticmethod
    def __split_into_dict(lst):
        return {x[0].lower(): x[1].lower() for x in map(lambda o: o.split(':'), lst)}

    @staticmethod
    def __sanitize_bullet_list(lst):
        return map(lambda o: o.strip(' -\n'), lst)

    def handle_hardware(self, prop):
        self.hardware = self.__split_into_dict(self.__sanitize_bullet_list(prop.content))

    def handle_os(self, prop):
        self.os = self.__split_into_dict(self.__sanitize_bullet_list(prop.content))

    def handle_software(self, prop):
        for sub_prop in prop.content:
            self.property_handler_map[sub_prop.heading.lower()](sub_prop)

    def handle_sources(self, prop):
        # TODO: Make this a dict
        print('  Sources:', end=' ')
        for sub_prop in prop.content:
            print(sub_prop.heading, end=' ')

    def handle_packages(self, prop):
        self.packages = list(self.__sanitize_bullet_list(prop.content))
