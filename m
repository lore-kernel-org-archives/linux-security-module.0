From: takondra@cisco.com (Taras Kondratiuk)
Date: Fri, 26 Jan 2018 13:02:52 -0800
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <da9b623c-dd0c-9aff-8eaa-43afa4714b34@landley.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<da9b623c-dd0c-9aff-8eaa-43afa4714b34@landley.net>
Message-ID: <151700057225.21956.4502484965110175077@takondra-t460s>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Rob Landley (2018-01-25 18:40:54)
> On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> > diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
> > index e1fd7f9dad16..d818df4f72dc 100644
> > --- a/Documentation/early-userspace/buffer-format.txt
> > +++ b/Documentation/early-userspace/buffer-format.txt
> 
> > +compressed and/or uncompressed cpio archives; arbitrary amounts
> > +zero bytes (for padding) can be added between members.
> 
> Missing "of" between amounts and zero. (Yeah it was in the original, but
> if you're touching it anyway...)
> 
> > +c_xattrs_size  8 bytes                Size of xattrs field
> > +
> > +Most of the fields match cpio_newc_header except c_mtime that contains
> > +microseconds. c_chksum field is dropped.
> > +
> > +xattr_size is a total size of xattr_entry including 8 bytes of
> > +xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
> > +fields of cpio header.
> 
> xattrs_size or xattr_size?
> 
> Total nitpicks, I know. :)

xattr_size here refers to size of each xattr_entry:
xattr_entry := xattr_size[8] + xattr_name + "\0" + xattr_value

I'll move this paragraph closer to that line.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
