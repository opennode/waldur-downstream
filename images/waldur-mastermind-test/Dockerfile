FROM centos:7

# YUM:
#  - epel-release configures EPEL repository needed to install python-pip
#  - gcc is needed to build Python binary modules installed by pip (TODO: list modules)
#  - git is needed to fetch Waldur Core source code from repository
#  - openldap-devel is needed to build nodeconductor-ldap plugin dependencies (python-ldap)
#  - openssl-devel id needed to ... (FXIME)
#  - postgresql-devel is needed to build psycopg2 (Waldur Core dependency) installed by pip
#  - python-devel is needed to build Python binary modules installed by pip (TODO: list modules)
#  - python-pip is needed to install Waldur dependencies
#  - xmlsec1 is needed by PySAML2 (dependency of djangosaml2 used in waldur-auth-saml2)
#    to support XML digital signatures and encryption: https://github.com/knaperek/djangosaml2#install
#  - libffi-devel is needed to build cryptography (dependency of waldur-azure)
#
# PIP:
#  - setuptools is needed to run setup.py tasks; setuptools does not work with Unicode since 25.1.2
#     - https://github.com/pypa/setuptools/issues/709
#     - https://github.com/pypa/setuptools/commit/857949575022946cc60c7cd1d0d088246d3f7540
#  - Waldur Core install_requires and test_requires dependencies are preinstalled to speed up testing process
#  - Waldur Core dependencies: https://code.opennodecloud.com/waldur/waldur-core/raw/develop/setup.py
#  - tblib is needed to display tracebacks correctly on running tests in parallel processes
#     - https://docs.djangoproject.com/en/1.11/ref/django-admin/#cmdoption-test-parallel
RUN yum --assumeyes install epel-release && \
    yum --assumeyes update ; \
    yum --assumeyes install git gcc openldap-devel openssl-devel postgresql-devel python-devel python-pip xmlsec1 libffi-devel && \
    yum clean all && \
    pip install --upgrade pip && \
    pip install --upgrade 'setuptools<=25.1.1' && \
    pip install \
        'Celery>=3.1.23,<3.2' \
        'croniter>=0.3.4,<0.3.6' \
        'Django>=1.11,<2.0' \
        'django-admin-tools==0.8.0' \
        'django-filter==1.0.2' \
        'django-fluent-dashboard==0.6.1' \
        'django-fsm==2.3.0' \
        'django-jsoneditor==0.0.7' \
        'django-model-utils==3.0.0' \
        'django-redis-cache>=1.6.5' \
        'django-rest-swagger==2.1.2' \
        'django-reversion==2.0.8' \
        'django-taggit>=0.20.2' \
        'djangorestframework>=3.6.3,<3.7.0' \
        'elasticsearch==5.4.0' \
        'iptools>=0.6.1' \
        'Pillow>=2.0.0' \
        'PyYAML>=3.10' \
        'pycountry>=1.20,<2.0' \
        'pyvat>=1.3.1,<2.0' \
        'redis==2.10.3' \
        'requests==2.11.1' \
        'sqlparse>=0.1.11' \
        'urllib3<1.18' \
        && \
    pip install \
        'ddt>=1.0.0,<1.1.0' \
        'factory_boy==2.4.1' \
        'freezegun==0.3.7' \
        'mock==2.0.0' \
        'mock-django==0.6.9' \
        'six>=1.9.0' \
        'sqlalchemy>=1.0.12' \
        && \
    pip install bandit tblib unittest-xml-reporting
