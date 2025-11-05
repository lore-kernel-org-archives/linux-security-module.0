Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29229224AEB
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301960; cv=none; b=FiD18lclbmgDGUbt9nny7UfdP/r6Em7Lupg5xGRYQJ4ZiIvAHJBKd6Z4eYx8HFrQ5pI/duXDht1IfzdwBdZVbRoqI+GHWOX3ZZD7P8QzIoZA5KtOczNDk92K4HI2vuVDjl62c5ZnKE+d7LoJj+yB4P5q/ysSAov2cR4gtGVh0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301960; c=relaxed/simple;
	bh=CXBidnbCR5ifmFwvHayw3FaO8i8qfw5gJZXUu4WTevA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YsSvKo+ZO5shkKv+9SY1Wms0CmtTvz+ixj+yYsydzm4pThb5Npe7nTDAij9wIp7jU1x0mcoe/x0dsquMQl4CqaO8gbQbDBp5Fy2kaPMDXnrnw58SrQRpsNTASfkTSdA2aE1Ph0IA+CTpwm3jceRa7fO0AsjqiV0XrIx/kAG7Xts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLVVHsI7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLVVHsI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762301956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hF/Q0Jxg/bJ4rsgyrnW9VOMqT1HQ3E8+/Upt51gSeWM=;
	b=hLVVHsI7bzOs9Ab3FSMinO2p7Anh3ZVRKQrtSKn6X3TmQZX9souzl+8RWOfVgkcZ0ZX+HG
	cp7ybCK1reXl+u4sakzV00I5pCIQWqjLMP/9aHJzEya7DRXGx0h8sWzHGkY7qCwlEbiAkK
	gN4kGwBSJupBcMU4v/5Vnhr0bhpTrq8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Aq9Jn-qwPzyAj69DXAIdlQ-1; Tue, 04 Nov 2025 19:19:15 -0500
X-MC-Unique: Aq9Jn-qwPzyAj69DXAIdlQ-1
X-Mimecast-MFC-AGG-ID: Aq9Jn-qwPzyAj69DXAIdlQ_1762301954
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso5677150a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Nov 2025 16:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301954; x=1762906754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF/Q0Jxg/bJ4rsgyrnW9VOMqT1HQ3E8+/Upt51gSeWM=;
        b=rkMzhd+uF7FpF/muPMNk7+DBtYH3gVChtl4CJ7HGNWilb+L8d2n6D4Fxlt6TzHnUL8
         7SNS1IypXqxHiWf4IYnXe/bkR2GAXzY/LYiOTTnDds3VnpeSyhvF7CDF/IyDwQ80Pi9B
         hBxg1chOXZ8YquSmOjY5TtWG61+JPBEr0O5o1DcR7LsLKcp148v8TK1cb5r3T9OKmdqE
         HgJc6UkZUDugRH02dmwPq5+vfF/IpF1u5n8G7V3Z8wJOrKIj8IAqDhWLH4mr2DgNhkbv
         FaXJ46FZInxi8/AjA2++4qENiiKsjociBMePJFNaAka9W697mFDUF15yJSt8tj6FBFXi
         6nJw==
X-Forwarded-Encrypted: i=1; AJvYcCWGK8MYOjDh8vDF9hERzn0FwnC/mszNZmLbfKMCOrtbT88hPDk7IngcUboiz8a4kvkhRp2MmPzNdH+SD1DiIW42tGt9jlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywskk0ZIIyfURzB39d3K6z6HitC/8X/fcKhaZ6U78r5zDZkJSC0
	ZnNjeT3YnvTed4R097gYEXOt3+48C1vd1nB6QpC9dTQpiUDVfofu0iUifO8oaP6Pljl8/Q03/ts
	ss8RUlG3XiJiOzGY2aOtmyVR0qzwYhtXulS9XiTx9ggYYyLCOP4cCbotGPe1etYFmvBp4YxP7PR
	PASw==
X-Gm-Gg: ASbGncsSGjP9Ar178LUVO2MjgyejjB5h/MimGYZOUnXEhrAGlswexHNX13R0dbchAbp
	do/zaGiXBErS7U5vWh8R7OvQoqPp0D70iF6Y9qGUYM9E9AhY9UvO3YDC7WbmOQbTYju+mldj5OQ
	dgJB+UCYoMJN9B7aAU+DnePkcsusi0blik7RDFDYaBTPbcF67yO9NqWWrE3lQj8hfOpKCD8XUu6
	sho6btiFJOg1Ac4MCD2C3lwGLifGkUKgDxh/djWlgrzWYFx0WhNPP5IkAjNVQ3CZ2q0z90hSjki
	WPViN5VNInILrAE6goqw46LUmDM/F8u9bz+VrWVXW3dGfjGn2+jCKox6wxTj8ETaEaFiWw==
X-Received: by 2002:a17:903:2405:b0:290:c0d7:237e with SMTP id d9443c01a7336-2962adaf2cbmr20013905ad.39.1762301953490;
        Tue, 04 Nov 2025 16:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvLsNYSLufcGqpq910+wiTcGPaxLeUOI30KPT7POMh/wI/jxby0rWhm6jQT1thiVu8Y4E3iw==
X-Received: by 2002:a17:903:2405:b0:290:c0d7:237e with SMTP id d9443c01a7336-2962adaf2cbmr20013465ad.39.1762301952858;
        Tue, 04 Nov 2025 16:19:12 -0800 (PST)
Received: from localhost ([2409:8924:a812:1670:4703:63e6:48fd:865d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a69d91sm39637355ad.95.2025.11.04.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:19:12 -0800 (PST)
Date: Wed, 5 Nov 2025 08:18:25 +0800
From: Coiby Xu <coxu@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FTXPDny2BRvQQTnJsC-24RBzatE-b04mg4br93bwlgs_1762301954
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Nov 02, 2025 at 10:43:04AM -0500, Paul Moore wrote:
>On Sun, Nov 2, 2025 at 10:06 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> On Sat, 2025-11-01 at 12:50 -0400, Paul Moore wrote:
>> > On Fri, Oct 31, 2025 at 3:41 AM Coiby Xu <coxu@redhat.com> wrote:
>> > >
>> > > Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
>> > > is enabled, IMA has no way to verify the appended module signature as it
>> > > can't decompress the module.
>> > >
>> > > Define a new LSM hook security_kernel_module_read_file which will be
>> > > called after kernel module decompression is done so IMA can access the
>> > > decompressed kernel module to verify the appended signature.
>> > >
>> > > Since IMA can access both xattr and appended kernel module signature
>> > > with the new LSM hook, it no longer uses the security_kernel_post_read_file
>> > > LSM hook for kernel module loading.
>> > >
>> > > Before enabling in-kernel module decompression, a kernel module in
>> > > initramfs can still be loaded with ima_policy=secure_boot. So adjust the
>> > > kernel module rule in secure_boot policy to allow either an IMA
>> > > signature OR an appended signature i.e. to use
>> > > "appraise func=MODULE_CHECK appraise_type=imasig|modsig".
>> > >
>> > > Reported-by: Karel Srot <ksrot@redhat.com>
>> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > ---
>> > > v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-coxu@redhat.com/
>> > >
>> > >  include/linux/lsm_hook_defs.h       |  2 ++
>> > >  include/linux/security.h            |  7 +++++++
>> > >  kernel/module/main.c                | 10 +++++++++-
>> > >  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
>> > >  security/integrity/ima/ima_policy.c |  2 +-
>> > >  security/security.c                 | 17 +++++++++++++++++
>> > >  6 files changed, 62 insertions(+), 2 deletions(-)
>> >
>> > We don't really need a new LSM hook for this do we?  Can't we just
>> > define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
>> > another call to security_kernel_post_read_file() after the module is
>> > unpacked?  Something like the snippet below ...
>>
>> Yes, this is similar to my suggestion based on defining multiple enumerations:
>> READING_MODULE, READING_COMPRESSED_MODULE, and READING_DECOMPRESSED_MODULE.
>> With this solution, IMA would need to make an exception in the post kernel
>> module read for the READING_COMPRESSED_MODULE case, since the kernel module has
>> not yet been decompressed.
>>
>> Coiby suggested further simplification by moving the call later.  At which point
>> either there is or isn't an appended signature for non-compressed and
>> decompressed kernel modules.
>>
>> As long as you don't have a problem calling the security_kernel_post_read_file()
>> hook again, could we move the call later and pass READING_MODULE_UNCOMPRESSED?
>
>It isn't clear from these comments if you are talking about moving
>only the second security_kernel_post_read_file() call that was
>proposed for init_module_from_file() to later in the function, leaving
>the call in kernel_read_file() intact, or something else?

Hi Paul and Mimi,

Thanks for sharing your feedback! Yes, you are right, there is no need
for a new LSM hook. Actually by not introducing a new LSM hook, we can
have a much simpler solution!

>
>I think we want to leave the hook calls in kernel_read_file() intact,
>in which case I'm not certain what advantage there is in moving the
>security_kernel_post_read_file() call to a location where it is called
>in init_module_from_file() regardless of if the module is compressed
>or not.  In the uncompressed case you are calling the hook twice for
>no real benefit?  It may be helpful to submit a patch with your
>proposal as a patch can be worth a thousand words ;)
>
>
>> > diff --git a/kernel/module/main.c b/kernel/module/main.c
>> > index c66b26184936..f127000d2e0a 100644
>> > --- a/kernel/module/main.c
>> > +++ b/kernel/module/main.c
>> > @@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file *f, const ch
>> > ar __user * uargs, int
>> >                        mod_stat_add_long(len, &invalid_decompress_bytes);
>> >                        return err;
>> >                }
>> > +
>> > +               err = security_kernel_post_read_file(f,
>> > +                                                    (char *)info.hdr, info.len,
>> > +                                                    READING_MODULE_DECOMPRESS);
>> > +               if (err) {
>> > +                       mod_stat_inc(&failed_kreads);
>> > +                       return err;
>> > +               }
>> >        } else {
>> >                info.hdr = buf;
>> >                info.len = len;
>>
>> == defer security_kernel_post_read_file() call to here ==

By moving security_kernel_post_read_file, I think what Mimi means is to
move security_kernel_post_read_file in init_module_from_file() to later
in the function,

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b261849362a..66725e53fef0c1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3678,6 +3678,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
  	struct load_info info = { };
  	void *buf = NULL;
  	int len;
+	int err;
  
  	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
  	if (len < 0) {
@@ -3686,7 +3687,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
  	}
  
  	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+		err = module_decompress(&info, buf, len);
  		vfree(buf); /* compressed data is no longer needed */
  		if (err) {
  			mod_stat_inc(&failed_decompress);
@@ -3698,6 +3699,14 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
  		info.len = len;
  	}
  
+	err = security_kernel_post_read_file(f, (char *)info.hdr, info.len,
+					     READING_MODULE);
+	if (err) {
+		mod_stat_inc(&failed_kreads);
+		free_copy(&info, flags);
+		return err;
+	}
+
  	return load_module(&info, uargs, flags);
  }

If we only call security_kernel_post_read_file the 2nd time for a
decompressed kernel module, IMA won't be sure what to do when
security_kernel_post_read_file is called for the 1st time because it
can't distinguish between a compressed module with appended signature or
a uncompressed module without appended signature. If it permits 1st
calling security_kernel_post_read_file, a uncompressed module without
appended signature can be loaded. If it doesn't permit 1st calling
security_kernel_post_read_file, there is no change to call
security_kernel_post_read_file again for decompressed module.

And you are right, there is no need to call
security_kernel_post_read_file twice. And from the perspective of IMA,
it simplifies reasoning if it is guaranteed that IMA will always access
uncompressed kernel module regardless regardless of its original
compression state. 

So I think a better solution is to stop calling
security_kernel_post_read_file in kernel_read_file for READING_MODULE.
This can also avoiding introducing an unnecessary
READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration and
can make the solution even simpler,

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index de32c95d823dbd..7c78e84def6ec7 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -107,7 +107,12 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
  			goto out_free;
  		}
  
-		ret = security_kernel_post_read_file(file, *buf, i_size, id);
+		/*
+		 * security_kernel_post_read_file will be called later after
+		 * a read kernel module is truly decompressed
+		 */
+		if (id != READING_MODULE)
+			ret = security_kernel_post_read_file(file, *buf, i_size, id);
  	}

Btw, I notice IMA is the only user of security_kernel_post_read_file so
this change won't affect other LSMs. For a full patch, please visit
https://github.com/coiby/linux/commit/558d85779ab5d794874749ecfae0e48b890bf3e0.patch

If there are concerns that I'm unaware of and a new
READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration is
necessary, here's another patch
https://github.com/coiby/linux/commit/cdd40317b6070f48ec871c6a89428084f38ca083.patch


>
>-- 
>paul-moore.com
>

-- 
Best regards,
Coiby

