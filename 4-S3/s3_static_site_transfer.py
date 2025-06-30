import boto3
import botocore

SOURCE_BUCKET = "limtruong-static-site"
DEST_BUCKET = "limtruong-static-site-clone"
REGION = "us-east-1"

s3 = boto3.resource("s3", region_name=REGION)

def transfer_all_objects():
    source_bucket = s3.Bucket(SOURCE_BUCKET)
    dest_bucket = s3.Bucket(DEST_BUCKET)

    for obj in source_bucket.objects.all():
        copy_source = {
            'Bucket': SOURCE_BUCKET,
            'Key': obj.key
        }

        dest_bucket.copy(copy_source, obj.key)
        url = f"https://{DEST_BUCKET}.s3.amazonaws.com/{obj.key}"
        print(f"Copied {obj.key} to {url}")

    print("Transfer complete!")
    website_url = f"http://{DEST_BUCKET}.s3-website-{REGION}.amazonaws.com"
    print(f'Clone URL = "{website_url}"')

if __name__ == "__main__":
    try:
        transfer_all_objects()
    except botocore.exceptions.ClientError as e:
        print(f"Error: {e}")
