Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834842;
	b=CVmRovjV4sK6ajMZmI31wsky9v1Y/PG3nz5sFgMl3qbkq0Lb/2A722NLi/KRUbSBjcBt
	 QCWGgNbKg+lcFBQ0Z1QQJOPdHC6Rk2I/yHtZ+mpypJAJl1YUzHdwFNw8eTXobwpJLTAJ+
	 eWcJBgcfhb4Nudtu+bXZSq+1NFVLI/68di9M94YbjS4nvr4NHuorkyGr9VQ4Psdl5mpxS
	 vu9Cm6bZnUAzMQwyRb0tHuQEJAyG8fYXNMwV76yMRYSJ7thEvVpTbYhna1NaiCkPbzCnu
	 x76Bbqt6A8iFVB9zdqXm4uqJN8zzudd/DvD692la3+NyobLRe3A0QPHrDJdtbB61EcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834842;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=r6p8uVYKDetOaXSZkkbXs6nfwrN9YCw9AiqQm77o3SI=;
	b=L7PXzw0MshsL7Kb6np48DObu08poBFq4JeqvY/iiiAoLGiGSoAxXOz8fo++gTm+eo1rr
	 VHPNpE/NRBtZo3IOJlRUf5lziQQFLuQuAh4iZQ7NOZ1uvwsSx3Bcvm9P2xvcDxVWwHxgI
	 2etAd5sEOlLuo550O/pt7pM5DEQImPcA6lawuH6sHwNrmExFUKd48n9Wz6D+YuU5BRGeS
	 jF9BKj8gM2EGs4iBS4MrTctfZ96dqDvRWpN2mIhPApdrg7sHZ8CyQGogCJqDcpYpQ5wS+
	 oQHJSthVGRCMgjz1eRFTWySEkTQSdOxMjgJzk3MFmXSzFQ1ecYYWuC7IJ66uAsrc7zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ocMcZJpG;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A8606A331;
	Sat, 24 Oct 2026 09:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70A8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ocMcZJpG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=r6p8uVYKDetOaXSZkkbXs6nfwrN9YCw9AiqQm77o3SI=; b=ocMcZJpG85PXlbEbSsTOldbePd
	0uSGjzfT17GKFbYwsR5/BUvT47JgF/SQTJ/8UvaioE0dLDU1qdm1mlfQkTsXNtDiZ+WpFQJHinwKQ
	yBnUcXkO6bjMJiBw05d90YDljtYyZ9KBpIOqbG5i4RPsdYXss0TaUpFCeZ3MrD+PHeNt7eZPeiHDj
	ewumTrltld+06hDAZOSqcAAf96OJgg4HGicibqReDpslgu310/IFPzAVo6vNJTycDq0AKdjmhHNRQ
	3YX9pTSCQ9prNzBd+GBZzF3F+TTPShuHgwRKVv24vCg3YPbLMND4sDRTix4VgBLXQg4IS2jUKwGwH
	68V1dWAw==;
Received: from [::1] (port=50492 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xKYEz-0000000FPh6-2fvw;
	Sat, 24 Oct 2026 11:40:40 +0200
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 11:40:39 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ima: audit failure to supply detached data for
 modsig
In-Reply-To: <9336bd484bcd0af6e9c88b7b546434e5081ab449.camel@linux.ibm.com>
References: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261021210145.1851396-5-Jeremy.Jean@oss.cyber.gouv.fr>
 <9336bd484bcd0af6e9c88b7b546434e5081ab449.camel@linux.ibm.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <77df0a0e445253254a15b4ad37388f6b@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-23 19:36, Mimi Zohar wrote:
> On Wed, 2026-10-21 at 21:01 +0000, Jérémy Jean wrote:
>> 
> 
>> @@ -326,15 +329,20 @@ int ima_collect_measurement(struct 
>> ima_iint_cache *iint, struct file *file,
>>  	if (!result)
>>  		iint->flags |= IMA_COLLECTED;
>>  out:
>> -	if (result) {
>> +	if (result || modsig_result) {
>>  		if (file->f_flags & O_DIRECT)
>>  			audit_cause = "failed(directio)";
>> 
>>  		take_dentry_name_snapshot(&filename, file->f_path.dentry);
>> 
>> -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
>> -				    filename.name.name, "collect_data",
>> -				    audit_cause, result, 0);
>> +		if (modsig_result)
>> +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
>> +					    filename.name.name, "collect_data",
>> +					    "failed-modsig", modsig_result, 0);
>> +		if (result)
>> +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
>> +					    filename.name.name, "collect_data",
>> +					    audit_cause, result, 0);
> 
> 
> Frederick Lawler's patch updated integrity_audit_msg() to include 
> errno.  These
> calls need to be updated.

Indeed, thanks for this.
I have just sent out a new version to take this and your other remark 
into
consideration.

Best,
Jérémy
