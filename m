Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E31CB9F0
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435481; cv=none; b=MluGDiot1uxsuQEF1vGQjcSyS7NTzI/OPxGpiqOpoqFcRwjU+UmbD5IYzK7uCJUgDO5l1Z1i407U56cTWl6oYuhH4oqzVVJXwsO5hBT64SWDuW9q+XCwdDds5YYdcPrG8Sb0bArF3VoElZujbXztxZKofVXR7GuAYPm/gmdHeZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435481; c=relaxed/simple;
	bh=hjk2Nb3FjeafKz0D7B3gcTDOlRasQKBiOuKgfkeZR1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOtl+itaPujTprV8Z9Q/YHe5rmubqWj3hBWti5jgtZAbhxErYtPmC6vzjcpj3N73NZT5JWf3APgDiMyOZa12IYXE6Vi3p2JLCBtVoX7h+BUcOIuBJEzLQkcSSW1OyycJb0iBA2l+/rpVmwcLkoSYKacoiqEN1HCKy5l89N/h6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihjY/1Gi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihjY/1Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742435479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00VnZr9jO8VuByi8MLDHm6KsHvC5R2pokiPIwqQJpHQ=;
	b=ihjY/1GiG77reT5r89iSWRTRitC6EhAt0BbqftJFSiuxQbclmt9V9Uk+lOdXvVEJSw3fP6
	j2BZOgWknEk4uuhAOi6B7dFXAc55nsTgVDUpxVBT/85AgOhAsFQhbmhrT6I8+AZC+IzGdS
	jMU0s15wvp5szYaH/OP9yDnrmiX+meM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-us51ET_TOn6wmhx3h5TLRQ-1; Wed,
 19 Mar 2025 21:51:13 -0400
X-MC-Unique: us51ET_TOn6wmhx3h5TLRQ-1
X-Mimecast-MFC-AGG-ID: us51ET_TOn6wmhx3h5TLRQ_1742435471
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CACE1956046;
	Thu, 20 Mar 2025 01:51:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DD51955DCD;
	Thu, 20 Mar 2025 01:51:07 +0000 (UTC)
Date: Thu, 20 Mar 2025 09:51:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-3-chenste@linux.microsoft.com>
 <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
 <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/19/25 at 12:27pm, Mimi Zohar wrote:
> On Wed, 2025-03-19 at 16:09 +0800, Baoquan He wrote:
> > On 03/17/25 at 06:04pm, steven chen wrote:
> > > Carrying the IMA measurement list across kexec requires allocating a
> > > buffer and copying the measurement records.  Separate allocating the
> > > buffer and copying the measurement records into separate functions in
> > > order to allocate the buffer at kexec 'load' and copy the measurements
> > > at kexec 'execute'.
> > > 
> > > This patch includes the following changes:
> > >  - Refactor ima_dump_measurement_list() to move the memory allocation
> > >    to a separate function ima_alloc_kexec_file_buf() which allocates
> > >    buffer of size 'kexec_segment_size' at kexec 'load'.
> > >  - Make the local variable ima_kexec_file in ima_dump_measurement_list()
> > >    a local static to the file, so that it can be accessed from 
> > >    ima_alloc_kexec_file_buf().
> > >  - Make necessary changes to the function ima_add_kexec_buffer() to call
> > >    the above two functions.
> > 
> > We may not need above details about code change because it's not so
> > difficult to get them from patch.
> 
> Agreed.  The changes don't even reflect the current patch.  Please remove the
> entire section.
> 
> > 
> > > 
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > ---
> > >  security/integrity/ima/ima_kexec.c | 67 +++++++++++++++++++++++++-----
> > >  1 file changed, 56 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > > index 8567619889d1..45170e283272 100644
> > > --- a/security/integrity/ima/ima_kexec.c
> > > +++ b/security/integrity/ima/ima_kexec.c
> > > @@ -15,6 +15,48 @@
> > >  #include "ima.h"
> > >  
> > >  #ifdef CONFIG_IMA_KEXEC
> > > +static struct seq_file ima_kexec_file;
> > > +
> > > +static void ima_reset_kexec_file(struct seq_file *sf)
> > > +{
> > > +	sf->buf = NULL;
> > > +	sf->size = 0;
> > > +	sf->read_pos = 0;
> > > +	sf->count = 0;
> > > +}
> > > +
> > > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > > +{
> > > +	vfree(sf->buf);
> > > +	ima_reset_kexec_file(sf);
> > > +}
> > > +
> > > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > > +{
> > > +	/*
> > > +	 * kexec 'load' may be called multiple times.
> > > +	 * Free and realloc the buffer only if the segment_size is
> > > +	 * changed from the previous kexec 'load' call.
> > > +	 */
> > > +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
> > > +		goto out;
> 
> The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
> ima_kexec_file.buf() hiding the fact that the above test always fails and falls
> through.  As a result, 'buf' is always being re-allocated.
> 
> > > +
> > > +	ima_free_kexec_file_buf(&ima_kexec_file);
> > > +
> > > +	/* segment size can't change between kexec load and execute */
> > > +	ima_kexec_file.buf = vmalloc(segment_size);
> > > +	if (!ima_kexec_file.buf)
> > > +		return -ENOMEM;
> > > +
> > > +	ima_kexec_file.size = segment_size;
> > > +
> > > +out:
> > > +	ima_kexec_file.read_pos = 0;
> > > +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * Copy the measurement list to the allocated memory
> > >   * compare the size of IMA measurement list with the size of the allocated memory
> > > @@ -26,23 +68,16 @@
> > >  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
> > >  				     unsigned long segment_size)
> > >  {
> > > -	struct seq_file ima_kexec_file;
> > >  	struct ima_queue_entry *qe;
> > >  	struct ima_kexec_hdr khdr;
> > >  	int ret = 0;
> > >  
> > >  	/* segment size can't change between kexec load and execute */
> > > -	ima_kexec_file.buf = vmalloc(segment_size);
> > >  	if (!ima_kexec_file.buf) {
> > > -		ret = -ENOMEM;
> > > -		goto out;
> > > +		pr_err("Kexec file buf not allocated\n");
> > > +		return -EINVAL;
> > >  	}
> > >  
> > > -	ima_kexec_file.file = NULL;
> > > -	ima_kexec_file.size = segment_size;
> > > -	ima_kexec_file.read_pos = 0;
> > > -	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
> > > -
> > >  	memset(&khdr, 0, sizeof(khdr));
> > >  	khdr.version = 1;
> > >  	/* This is an append-only list, no need to hold the RCU read lock */
> > > @@ -79,8 +114,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
> > >  	*buffer_size = ima_kexec_file.count;
> > >  	*buffer = ima_kexec_file.buf;
> > >  out:
> > > -	if (ret == -EINVAL)
> > > -		vfree(ima_kexec_file.buf);
> > >  	return ret;
> > >  }
> > >  
> > > @@ -119,6 +152,12 @@ void ima_add_kexec_buffer(struct kimage *image)
> > >  		return;
> > >  	}
> > >  
> > > +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> > > +	if (ret < 0) {
> > > +		pr_err("Not enough memory for the kexec measurement buffer.\n");
> > > +		return;
> > > +	}
> > > +
> > >  	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> > >  				  kexec_segment_size);
> > >  	if (!kexec_buffer) {
> > > @@ -140,6 +179,12 @@ void ima_add_kexec_buffer(struct kimage *image)
> > >  	image->ima_buffer_size = kexec_segment_size;
> > >  	image->ima_buffer = kexec_buffer;
> > >  
> > > +	/*
> > > +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> > > +	 * and it will vfree() that buffer.
> > > +	 */
> > > +	ima_reset_kexec_file(&ima_kexec_file);
> > 
> > I can't see why we need call ima_reset_kexec_file() here. If we need
> > reuse the buffer, we will reset the needed fields at the end of
> > ima_alloc_kexec_file_buf(). Not sure if I miss anything.
> 
> Without ima_reset_kexec_file(), calling 'kexec load' consecutively without
> "kexec -s -e" in between fails.
> 
> # kexec -s -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img --reuse-cmdline
> # kexec -s -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img --reuse-cmdline
> Killed
> 
> As mentioned above, the call to ima_reset_kexec_file() resets
> ima_kexec_file.buf, so the segment size test always fails and the memory is
> being allocated.

Indeed, I didn't realize this.

