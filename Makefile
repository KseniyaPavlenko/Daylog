deploy:
	flutter build web --web-renderer canvaskit && \
	firebase deploy --only hosting