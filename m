Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D00192B82
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436419; cv=none; b=OkMeVB4hDqL7MlLlKSmGqaVZknc5dnzKBvOgKTUn1FnmX7a59Y/+Fh7mjGML11Z+rSefNMNBXbBYeIyN577LUk3OtJxXDVPTxgTPwM2JwDpcxfQDRycs0l6WPcNFm9c3WvwgJK0qTVvCJSQVANUNRETRpzSp7izsky9mDrFVQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436419; c=relaxed/simple;
	bh=Bbcm5ljaoVPeW/+Ua5xqsem3RVsmM40OrHRDG1Y8/EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS3J7EvaC4mbMZZ0y1UB5ozEwJhxYRH1uuZD+O1ZDRtsziQPLGE7fZ/SGB0APZMnzKBdRMf9Z/bFsMiFYSv5QPXOFvVelWJfNwIIQMiQupdAu5evBGp5Be0dlpBcDH0gtc3/Ey/KvG8x+Hr3su0UQZoRtWmXNdtruTNSrlHRNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APRB8zvC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APRB8zvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742436416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbqEoX14ORu2/rmOhU9xIw+MPDfsbKLRu6ORYCqCp6E=;
	b=APRB8zvCOFLLhLLd+xWWlUw2kDp3ymHpFyXEoKD02AQ3E4JreKfsRKRtnjfZQAzaop1Wld
	5ey/duKQyvsXNqGkxIz9VU3+nVvMlvN8QYMHDy0tSjyEMsJ+AM+jpmy8TVC6KD3UvKo4r0
	i3yr691HHz0vdzIZl9Ypw0i9cg78oSg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-Xn7FA1hGMWW8Z-MHK8mlEQ-1; Wed,
 19 Mar 2025 22:06:52 -0400
X-MC-Unique: Xn7FA1hGMWW8Z-MHK8mlEQ-1
X-Mimecast-MFC-AGG-ID: Xn7FA1hGMWW8Z-MHK8mlEQ_1742436410
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7653D19560B4;
	Thu, 20 Mar 2025 02:06:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C00918001D4;
	Thu, 20 Mar 2025 02:06:41 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:06:37 +0800
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
Message-ID: <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-7-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/17/25 at 06:04pm, steven chen wrote:
...snip...
> ---
>  kernel/kexec_file.c                | 10 ++++++
>  security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>  2 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 606132253c79..ab449b43aaee 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>  }
>  #endif
>  
> +static void kimage_file_post_load(struct kimage *image)
> +{
> +#ifdef CONFIG_IMA_KEXEC
> +	ima_kexec_post_load(image);
> +#endif
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  
>  	kimage_terminate(image);
>  
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);

machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
we should use it to do things post load, but not introducing another
kimage_file_post_load(). 

> +
>  	ret = machine_kexec_post_load(image);
>  	if (ret)
>  		goto out;
...snip...

