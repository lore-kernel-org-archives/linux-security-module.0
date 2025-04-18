Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F42522A1
	for <linux-security-module@vger.kernel.org>; Fri, 18 Apr 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744950823; cv=none; b=FsBJrs1HoxSZcuvjSjJ9XHpFgCqwUB3i4IFrdUyo65epNmjsq5DlTB0AUP6z84WRzC5n0AXAl+/XBagGJ1/NDDyhijX7XDC5EOpptJwFxfFTGwaHbOwWipKITGmuMTMkQJGtwFIEkyeNozbl2fKa41tiPrnZfNYCYLoWW57vy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744950823; c=relaxed/simple;
	bh=LTUP2n/LOQ1CRKDOZOzdgkRQ30gJSVxW7Fz61LvJM7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWjRG0FpEadpjsv9GQDST9kJ8AWlLaCShavYHlaWG3Y9A7iNOzDWDq3EUqG7b20yBgDD8zxGKkXFcZcz0UH9wdsfEFrNj7w4SOdvxYgiNkmxlv65JicecgFaXipNmwzRfQZ5VFpYYFps+4k+uKI0KUwDh4dxQYBpxvSJugN6pYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bp/QieGl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bp/QieGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744950819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3F5hBYyFCUjuYWeqvOWU5reA4YYpl84M01/MAUamts=;
	b=Bp/QieGl4Efvp3YrOEN/IMVe5JkWBw9szQ5Vn+urbppYsWk0IVnLHYaJZ3ZHr/O9fLNac/
	PIf4tw9AAEYj+DrfO5M2z0HttvFkdQTr+g0+R7z96OXrH61C1NdYvSeOPL+z9B0zhG65uQ
	ZetXBlmCLn1xuDwO8Wqh774cfnn8LDA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-nLnjpkB-MiCB15MIqwLSWg-1; Fri,
 18 Apr 2025 00:33:35 -0400
X-MC-Unique: nLnjpkB-MiCB15MIqwLSWg-1
X-Mimecast-MFC-AGG-ID: nLnjpkB-MiCB15MIqwLSWg_1744950813
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68132180048E;
	Fri, 18 Apr 2025 04:33:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19ACE19560A3;
	Fri, 18 Apr 2025 04:33:29 +0000 (UTC)
Date: Fri, 18 Apr 2025 12:33:26 +0800
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
Subject: Re: [PATCH v12 2/9] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <aAHWFjfQgDBq84lH@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-3-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Steven,

On 04/15/25 at 07:10pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> In the current implementation, the ima_dump_measurement_list() API is 
> called during the kexec "load" phase, where a buffer is allocated and 
> the measurement records are copied. Due to this, new events added after
> kexec load but before kexec execute are not carried over to the new kernel
> during kexec operation
> 
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.

Seems you didn't add note in this patch log to mention that the IMA
measurement list fails to verify when doing two consecuritv "kexec -s -l"
with/without a "kexec -s -u" in between. When people do bisecting and
come to this patch, she/he will see the failure even though it's not a
fatal blocker.

====
After moving the vfree() here at this stage in the patch set, the IMA
measurement list fails to verify when doing two consecutive "kexec -s -l"
with/without a "kexec -s -u" in between.  Only after "ima: kexec: move IMA log
copy from kexec load to execute" the IMA measurement list verifies properly with
the vfree() here.
====


> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 650beb74346c..b12ac3619b8f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,26 +15,46 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +
> +	return 0;
> +}
> +
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
> -	struct seq_file ima_kexec_file;
>  	struct ima_queue_entry *qe;
>  	struct ima_kexec_hdr khdr;
>  	int ret = 0;
>  
>  	/* segment size can't change between kexec load and execute */
> -	ima_kexec_file.buf = vmalloc(segment_size);
>  	if (!ima_kexec_file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +		pr_err("Kexec file buf not allocated\n");
> +		return -EINVAL;
>  	}
>  
> -	ima_kexec_file.file = NULL;
> -	ima_kexec_file.size = segment_size;
> -	ima_kexec_file.read_pos = 0;
> -	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
> -
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
> @@ -71,8 +91,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	*buffer_size = ima_kexec_file.count;
>  	*buffer = ima_kexec_file.buf;
>  out:
> -	if (ret == -EINVAL)
> -		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
>  
> @@ -111,6 +129,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("Not enough memory for the kexec measurement buffer.\n");
> +		return;
> +	}
> +
>  	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>  				  kexec_segment_size);
>  	if (!kexec_buffer) {
> -- 
> 2.43.0
> 

