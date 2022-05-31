SHELL := /bin/bash

FVM := [[ -d ".fvm/" ]] && fvm

install:
	$(call multi-dir-template, \
		echo ">> Run flutter pub get on $$DIR...";, \
		$(FVM) flutter pub get || flutter pub get; \
	);

clean:
	$(call multi-dir-template, \
		echo ">> Run flutter clean on $$DIR...";, \
		$(FVM) flutter clean || flutter clean; \
	);

define multi-dir-template
	for DIR in */; do \
  	${1} \
		cd $$DIR; \
		if [[ "$$DIR" == "agriaku_mitra_app/" ]]; then \
			for DIR in app modules; do \
				cd $$DIR; \
				if [[ -f "pubspec.yaml" ]]; then \
					${2} \
				else \
					for DIR in */; do \
						cd $$DIR; \
						if [[ -f "pubspec.yaml" ]]; then \
							${2} \
						else \
							for DIR in */; do \
								cd $$DIR; \
								echo $$DIR; \
								${2} \
								cd ..; \
							done; \
						fi; \
						cd ..; \
					done; \
				fi; \
				cd ..; \
			done; \
		elif [[ -f "pubspec.yaml" ]]; then \
			${2} \
		fi; \
		cd ..; \
	done
endef