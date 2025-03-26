Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0EF13777E
	for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956100; cv=none; b=IgP+PZQExOcd84RuQIAOUcIl4rKiTS+Qa2R5Z5oltRl2eXzyxlzYH33JWSr0NHfPJZeSf38JJQWXv8JctGMz8VHp8znU83I1mBEKs3y7uS2J2fWruL7APRnTsxA4WTsTtKJ250PZp1hG+KC0qy6R0ipd/VPOchSh2BRyDVxKKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956100; c=relaxed/simple;
	bh=S8f/6L6RJsMu2ZDf3XzJdIwUzr4pV//GmElet+hzG2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCC7f2EZy1JrCCKwPJOhtdW/6g3FKPLwBYj8RdA27cTDOCswWDRsClNnpQaJNCCBngzxYiVAKevMnjp+w9maYe39j4Jj7s/AxntLMuCk8DDF4+H7Dy0pbf3pQsv+rrKWodeh97CZmyt1wSpuV784Lw14LvR7305D9ioegSrBcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIvUmsZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIvUmsZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742956097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpwLopG/y4QsEDTE7uR/BjKfEYIxvRxD91VY/RN0u38=;
	b=BIvUmsZ0iGJ6F5886KiwRV/CNHahmxka7rv+msfXEtZ8tde6fZQPTko/lVLcymY6XpSEkj
	P5d8Ui1uMdmvnaOROIUCU8YIZDtu4N3ATi8gIZaQ+qsYXLvlA0vHW419V2StPq78MqyohI
	AdcEbHr9WJXF2ZtWCQcadWoVx7ITsSI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-BU-CW3qUPCm4PVw89ZN9DA-1; Tue,
 25 Mar 2025 22:28:14 -0400
X-MC-Unique: BU-CW3qUPCm4PVw89ZN9DA-1
X-Mimecast-MFC-AGG-ID: BU-CW3qUPCm4PVw89ZN9DA_1742956092
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3628196D2CC;
	Wed, 26 Mar 2025 02:28:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.203])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13EF21801A69;
	Wed, 26 Mar 2025 02:28:07 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:27:58 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <Z+NmLtn0vojVYJ3H@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
 <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
 <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/25/25 at 03:27pm, steven chen wrote:
> On 3/24/2025 4:00 AM, Baoquan He wrote:
> > On 03/21/25 at 09:23am, steven chen wrote:
> > > On 3/19/2025 7:06 PM, Baoquan He wrote:
> > > > On 03/17/25 at 06:04pm, steven chen wrote:
> > > > ...snip...
> > > > > ---
> > > > >    kernel/kexec_file.c                | 10 ++++++
> > > > >    security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
> > > > >    2 files changed, 40 insertions(+), 21 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > index 606132253c79..ab449b43aaee 100644
> > > > > --- a/kernel/kexec_file.c
> > > > > +++ b/kernel/kexec_file.c
> > > > > @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
> > > > >    }
> > > > >    #endif
> > > > > +static void kimage_file_post_load(struct kimage *image)
> > > > > +{
> > > > > +#ifdef CONFIG_IMA_KEXEC
> > > > > +	ima_kexec_post_load(image);
> > > > > +#endif
> > > > > +}
> > > > > +
> > > > >    /*
> > > > >     * In file mode list of segments is prepared by kernel. Copy relevant
> > > > >     * data from user space, do error checking, prepare segment list
> > > > > @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > >    	kimage_terminate(image);
> > > > > +	if (!(flags & KEXEC_FILE_ON_CRASH))
> > > > > +		kimage_file_post_load(image);
> > > > machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
> > > > we should use it to do things post load, but not introducing another
> > > > kimage_file_post_load().
> > > Hi Baoquan,
> > > 
> > > Could you give me more detail about this?
> > I mean machine_kexec_post_load() is the place where post load operations
> > are done, including kexec_load and kexec_file_load. There's no need to
> > specifically introduce a kimage_file_post_load() to do post load
> > operaton for kexec_file_load.
> 
> Hi Baoquan,
> 
> Updating the machine_kexec_post_load() API to carry flags would indeed
> require changes to multiple files. This approach involves the condition
> check if (!(flags & KEXEC_FILE_ON_CRASH)) and ensuring that the flags are
> properly passed and handled across the relevant file
> 
> if just adding a API kimage_file_post_load() here, it is much easy and
> clean, right?

Hmm, it's easier, while maybe not good. We should not repeatedly
introduce similar things into codes. Here, it's similar as
what kexec_apply_relocations() and arch_kexec_apply_relocations() are
doing. 

int machine_kexec_post_load(struct kimage *image) 
{
#ifdef CONFIG_IMA_KEXEC
        ima_kexec_post_load(image);
#endif
	return arch_machine_kexec_post_load();
}

Then a generic arch_machine_kexec_post_load(struct kimage *image)
{return 0;} version, and a arm64 specific version. 

Is it OK to you?

