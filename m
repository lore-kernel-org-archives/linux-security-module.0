From: rob@landley.net (Rob Landley)
Date: Thu, 25 Jan 2018 20:40:54 -0600
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <1516850875-25066-2-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
Message-ID: <da9b623c-dd0c-9aff-8eaa-43afa4714b34@landley.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
> index e1fd7f9dad16..d818df4f72dc 100644
> --- a/Documentation/early-userspace/buffer-format.txt
> +++ b/Documentation/early-userspace/buffer-format.txt

> +compressed and/or uncompressed cpio archives; arbitrary amounts
> +zero bytes (for padding) can be added between members.

Missing "of" between amounts and zero. (Yeah it was in the original, but
if you're touching it anyway...)

> +c_xattrs_size  8 bytes		 Size of xattrs field
> +
> +Most of the fields match cpio_newc_header except c_mtime that contains
> +microseconds. c_chksum field is dropped.
> +
> +xattr_size is a total size of xattr_entry including 8 bytes of
> +xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
> +fields of cpio header.

xattrs_size or xattr_size?

Total nitpicks, I know. :)

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
