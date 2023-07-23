from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import generics

from .models import Memo
from .serializers import MemoSerializer


class MemoListView(generics.ListAPIView):
    queryset = Memo.objects.all()
    serializer_class = MemoSerializer


class MemoRetrieveView(generics.RetrieveAPIView):
    queryset = Memo.objects.all()
    serializer_class = MemoSerializer

def health_check(request):
    return HttpResponse(status=200)