from rest_framework import serializers
from .models import Memo


class MemoSerializer(serializers.ModelSerializer):
    created_at = serializers.DateTimeField(format="%Y-%m-%d %H:%M", read_only=True)
    updated_at = serializers.DateTimeField(format="%Y-%m-%d %H:%M", read_only=True)

    class Meta:
        model = Memo
        fields = ['id', 'title', 'created_at', 'updated_at']