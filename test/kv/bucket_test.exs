defmodule KV.BucketTest do
  # Able to use async due to no interaction with global values.
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key and returns value", %{bucket: bucket} do
    KV.Bucket.put(bucket, "soda", 4)
    KV.Bucket.put(bucket, "candy", 6)

    assert KV.Bucket.delete(bucket, "soda") == 4
    assert KV.Bucket.get(bucket, "soda") == nil
  end
end
