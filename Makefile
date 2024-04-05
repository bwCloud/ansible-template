# The tag associated to your role
TAG=
PLAYBOOK=./playbooks/bwCloud.yml
GROUP=bwCloud

all:
	ansible-playbook \
		--syntax-check \
		$(PLAYBOOK)

	ansible-playbook \
		--check \
		$(PLAYBOOK)


test:
	ansible \
		$(GROUP) \
		-m shell \
		-a 'echo $$HOSTNAME'


run:
	ansible-playbook \
		$(PLAYBOOK) \
		$(if $(TAG), --tags $(TAG), )

