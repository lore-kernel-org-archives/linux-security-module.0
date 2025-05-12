Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354321FF49;
	Mon, 12 May 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059807; cv=none; b=iri4hyhBvfqTDRCDBWVRPhNKgSFLV9NaMo8w321r8CAlIvYE8l8kGHa7MTenz+Mx2Zg20iNyfTsL1p96EjlfPu3sh04iQNFMOPEKVTzJ0X6xmNtGeckvjOA+IJ4E42KyvWtw37m+NJcZL8j8ewo9v9/zGDekQgC+oTcXzA15Rik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059807; c=relaxed/simple;
	bh=duTsBJvizo9vU/fD4ogQ3/7fY2QmS2nQwF34opvHxF0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hV7y90dZkHJX7uxK55hSbo9H8FImQN+nyEycHBYMcLyYOuOiNsDtk0+lxER3TbVwzToSbPa/R8SJcwOLHgRTk184sr+jVuZopit8k8QWg2yKr8BINzCy9Wx+JSMetWupl+WPX8bqy28xBYX3FJvWDv6yr57QbeOI8cq1UATCUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bxaNLGZn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bxaNLGZn"
Received: from [100.70.33.9] (unknown [172.200.70.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id 10728211D8CE;
	Mon, 12 May 2025 07:23:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10728211D8CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747059806;
	bh=bsRyGKaV8sRJpQq5Zc/i6T71Ud1O1WM0d3J8aE2ryTI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bxaNLGZnaWOn4pztP7LAHZSNR6oUEN7p2ff6LADZBG2eyd8ca5OtAL4bBgiy7h0zV
	 o0LSARw9BkeXDHj54jQFDmAFSN++gqBUtXl0OyphrZ2NCOPZFaa8xaxWamWb7kAK6y
	 SgS/N+JEflqT9Sb9poZ36Zz2ugSIGn+JBFtvNyEM=
Message-ID: <c0dcf292-4c43-4e87-8016-34194f2bddb4@linux.microsoft.com>
Date: Mon, 12 May 2025 07:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250502200337.6293-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/2025 1:03 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
>
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kenrel.
>
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 38cb2500f4c3..7362f68f2d8b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	void *kexec_buffer = NULL;
>   	int ret;
>   
> +	if (image->type == KEXEC_TYPE_CRASH)
> +		return;
> +
>   	/*
>   	 * Reserve extra memory for measurements added during kexec.
>   	 */

Hi Baoquan,

Could you tell me when will you have time to validate kdump scenario 
using this patch?

This patch is based on the next-integrity branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/

Thanks,

Steven

