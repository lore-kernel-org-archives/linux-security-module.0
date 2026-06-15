Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FC274FD1;
	Mon, 15 Jun 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509422; cv=none; b=rFOYsXh5+ESArMXD/FT+PfAHPWBStwMTQt3C27S6HrZipK03r/zWiuM/aC2RV2n9uRU+nG/stxK+OBEOlpNRsI0gIMD+dhOCPYWRCWcjbcKNmTczMfh6Ukcx7xLlfvpcKdouLFnBjHanIzX6FDNeVfcZnPgGagEvecEgz3Sxbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509422; c=relaxed/simple;
	bh=28K2j26aCqXtjw5gXz4mCkYmJ6UK5OnO/rXxJMgdvLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrGla1c+DeFyUYt2vWfJ4qwWDqiWcVG71abKO1yJmHYAtyzjfxRBwtMq9dn5WWvMTwfVbZrM7Os//NouCy35do8jayJYUGIbfCSh+2VXSAU0snB/yxv7A7nz6u/YFFHhgvLDwNcPOM6twbt/k+eReMD0qtPCzKDkeJGFZuiL4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gf1jc2WPTzsWPl;
	Mon, 15 Jun 2026 15:20:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id BCE2140572;
	Mon, 15 Jun 2026 15:25:30 +0800 (CST)
Received: from [10.81.207.22] (unknown [10.81.207.22])
	by APP1 (Coremail) with SMTP id LxC2BwBn087WqC9qE+P7AA--.50004S2;
	Mon, 15 Jun 2026 08:25:30 +0100 (CET)
Message-ID: <d86a9834-5f0e-4e6c-a181-0b6bd81caec5@huaweicloud.com>
Date: Mon, 15 Jun 2026 09:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash functions
To: Mimi Zohar <zohar@linux.ibm.com>, Daniel Hodges <git@danielhodges.dev>
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aYNprpzxppKE0Gf2@fb.com>
 <20260206024240.19059-1-git@danielhodges.dev>
 <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
 <c1d570271884159e6c14617fa7dcd39bc2103e45.camel@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <c1d570271884159e6c14617fa7dcd39bc2103e45.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBn087WqC9qE+P7AA--.50004S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4UGFyxCw1xGr18Kw1ftFb_yoW8AFWxpF
	WrWayDtrWDKFyUCFnxt3Z5ZrykC3ySkw15Jry8GryYva9FvFsYqr4xC3WFga4kGr18Gw1Y
	qr4ay39xZ3WqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGovakYaugABsI

On 3/9/2026 4:03 PM, Mimi Zohar wrote:
> On Thu, 2026-02-19 at 10:26 +0100, Roberto Sassu wrote:
>> On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
>>> The crypto_shash_update() and crypto_shash_final() functions can fail
>>> and return error codes, but their return values were not being checked
>>> in several places in security/integrity/evm/evm_crypto.c:
>>>
>>> - hmac_add_misc() ignored returns from crypto_shash_update() and
>>>    crypto_shash_final()
>>> - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
>>> - evm_init_hmac() ignored returns from crypto_shash_update()
>>>
>>> If these hash operations fail silently, the resulting HMAC could be
>>> invalid or incomplete, which could weaken the integrity verification
>>> security that EVM provides.
>>>
>>> This patch converts hmac_add_misc() from void to int return type and
>>> adds proper error checking and propagation for all crypto_shash_*
>>> function calls. All callers are updated to handle the new return values.
>>> Additionally, error messages are logged when cryptographic operations
>>> fail to provide visibility into the failure rather than silently
>>> returning error codes.
>>>
>>> Fixes: 66dbc325afce ("evm: re-release")
>>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>>
>> After fixing the minor issue below:
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Thanks Daniel, Roberto.  Daniel there are a couple of places where the line
> length is greater than 80.  To see them, add "--max-line-length=80" to
> scripts/checkpatch.pl.  I'd appreciate your fixing them.  Otherwise, the patch
> looks good.

Daniel, do you have time to fix the style issues, so that we upstream 
your patch?

Thanks

Roberto

