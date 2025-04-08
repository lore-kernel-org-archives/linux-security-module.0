Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A51A9B3E
	for <linux-security-module@vger.kernel.org>; Tue,  8 Apr 2025 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079052; cv=none; b=EeF6wVRnERM7E/ZadbbC4awA3UkPad3HWOHsC2VZ1QWY66gWvZNm0/eVp02YQOy25So4/Be38HKRV1TNidwlapk60Zy1I5SFJKc6hsV4NLe0LotTL+c9dFBckDScFsi6obLksxRzrbm3kbJI2XYiEnNyhfkOOzEXe7U06YsSMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079052; c=relaxed/simple;
	bh=MdkpQCnMo49opJex7OZUG+NIbeQFZNJQY/fbJ6jtgho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgCsII9RBqpR9dI3Z/WOKD/CT9LYIwjOImCCZTpsbkXU8ZW4JF6S2jE6prFt/SldXy95duUXvb8C7ZdDPEtBgsX3MY4PhS22j+VqTRMkJnTR1+0d3eq/xXFyaI9loQOM0B4Pt9YFZIFnumiKCfO8rwS2OEzelh2iP0SfZMq9l6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OD1W9KMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD1W9KMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744079048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7shp0i8xV6W4sEMIfoyEtGIoaU0RHBOh45LNxxy8wY=;
	b=OD1W9KMoJbw9AcFui1abBTsTYzqPwPRubYygmae/7BLQsWikmQq/Lva1fG5YRuKNYwanfm
	CNuRe0C4wfaFP1+DPAdzN3NbyCy/UJpkOO37UHo3cFxsEe+X0ulJKV0yMl40HKyyejahLe
	QfgltisL8kztjW30SixWTeEiGAFMxSM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-fVNTxx_CPL6CJ9AhxUkyVA-1; Mon,
 07 Apr 2025 22:24:04 -0400
X-MC-Unique: fVNTxx_CPL6CJ9AhxUkyVA-1
X-Mimecast-MFC-AGG-ID: fVNTxx_CPL6CJ9AhxUkyVA_1744079042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CEC01956048;
	Tue,  8 Apr 2025 02:24:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71DE6180B48C;
	Tue,  8 Apr 2025 02:23:58 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:23:53 +0800
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
Subject: Re: [PATCH v11 1/9] ima: rename variable the set_file "file" to
 "ima_kexec_file"
Message-ID: <Z/SIudAyHVspsTa4@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-2-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-2-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/02/25 at 05:47am, steven chen wrote:
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'. IMA log is then carried
> over to the new kernel after kexec 'execute'. However, the time gap
> between kexec load and kexec reboot can be very long. During this
> time window, new events extended into TPM PCRs miss the chance
> to be carried over to the second kernel.
>  
> To address the above, the following approach is proposed:
>   - Allocate the necessary buffer during the kexec load phase.
>   - Populate this buffer with the IMA measurements during
>     the kexec execute phase.
> 
> In the current implementation, a local variable "file" of type seq_file
> is used in the API ima_dump_measurement_list() to store the IMA measurements
> to be carried over across kexec system call. To make this buffer accessible
> at kexec 'execute' time, rename it to "ima_kexec_file" before making it
> a file variable to better reflect its purpose.
> 
> Renaming the local variable "file" of type seq_file defined in the 
> ima_dump_measurement_list function to "ima_kexec_file" will improve code
> readability and maintainability by making the variable's role more explicit.

Seems it's clearer with below paragraph to replace the whole log:

=====
Rename the local variable "file" of type seq_file defined in the 
ima_dump_measurement_list function to "ima_kexec_file" to improve code
readability and maintainability by making the variable's role more explicit.
=====

The code change looks good to me.


> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

If there's code change in patch content, the reviewing tag should be
reset so that reviewing is taken again on the new change.

> ---
>  security/integrity/ima/ima_kexec.c | 31 +++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 9d45f4d26f73..650beb74346c 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -18,30 +18,30 @@
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
> +	struct seq_file ima_kexec_file;
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
>  	struct ima_kexec_hdr khdr;
>  	int ret = 0;
>  
>  	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	file.file = NULL;
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> +	ima_kexec_file.file = NULL;
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>  
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>  			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
>  			ret = -EINVAL;
>  			break;
> @@ -55,23 +55,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
>  	 */
> -	khdr.buffer_size = file.count;
> +	khdr.buffer_size = ima_kexec_file.count;
>  	if (ima_canonical_fmt) {
>  		khdr.version = cpu_to_le16(khdr.version);
>  		khdr.count = cpu_to_le64(khdr.count);
>  		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>  	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>  
>  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>  			     true);
>  
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
>  out:
>  	if (ret == -EINVAL)
> -		vfree(file.buf);
> +		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

