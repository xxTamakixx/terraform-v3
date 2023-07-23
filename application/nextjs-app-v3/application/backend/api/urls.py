from django.urls import path

from api.views import MemoListView, MemoRetrieveView
from api.views import health_check


urlpatterns = [
    path('list-memos/', MemoListView.as_view(), name='list-memos'),
    path('detail-memo/<str:pk>/', MemoRetrieveView.as_view(), name='detail-memo'),
    path('healthz/', health_check),
]