Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84C282F32;
	Fri, 20 Mar 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025934; cv=none; b=mThafek9IxHqIOAvKOilYjPovNUGqRtjVku6JHTyTTt4wnTzs5gWifWcVtec/IqksHlzZJmgd3jJHo3MgmpWoiO3kMYL/rAxstBuBJEVxk9GTdUcgGsafnFGtoZXjeIp6k4u7qYHL/Z2s7zm3UFE/LK0poD/x/Y+tOBbuV7LqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025934; c=relaxed/simple;
	bh=qk4VTItA9agI286S1iP+qevIWA8krtccqNwzrRb/aBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxSeBYnHs9La7qvLESOuy+dS9xQm4uwPoe8U5JdrhRCeEOf9tZ+VoTl7wCxaWUjCXR8xXaNICc7gHZ4Z83d27bFaCJ0C7FNdlNbyFgIGmwPAvgEY2piLcVsVl2eLiHLYOElqZvhr57ZczxVvrU/sSuWBGj/gghOHwoOMV6RdItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hbbomBaG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hbbomBaG"
Received: from [192.168.1.10] (c-67-168-176-124.hsd1.wa.comcast.net [67.168.176.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8BF020B6F01;
	Fri, 20 Mar 2026 09:58:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8BF020B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774025932;
	bh=b9xAtUsCFiluKTtH26H8O3XHZI6EJ/ehZH7lQahfIjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hbbomBaG9iUX0poRNazn0EpjyMaYnwQ8FdgPCFFgEYLn4t4eYdItUkhHQhUjzzHOY
	 4O8KsMbGs0F8oV3DNE5pr2FifvoieCZvhNPO1Uu1B3vCb+lPfHpbrvUZZTxQTSw7CC
	 +CUhAFCKwBDOlFzwAsHscApToMRM0VcW7G0Waze8=
Message-ID: <c9258708-2db2-4c08-998f-e67a681781da@linux.microsoft.com>
Date: Fri, 20 Mar 2026 09:58:52 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ima: Add support for staging measurements for
 deletion
To: Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
 <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
 <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
 <25e0a273-9044-4e0d-9812-0171ec99e1b7@linux.microsoft.com>
 <ffe1d4645a66a690892163be8e16c4b5d24a690d.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <ffe1d4645a66a690892163be8e16c4b5d24a690d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/2026 5:41 AM, Mimi Zohar wrote:
> On Thu, 2026-03-19 at 14:31 -0700, steven chen wrote:
>
>>> - Support for deleting N measurement records (and pre-pending the remaining
>>> measurement records)
>> Is there any problem to bring work of "stage" step together to the
>> deletion step?
>>
>> "Trim N" method does everything that "staged" method can do, right?
>> what's the "stage" method can do but "trim N" method can't do?
>>
>> in user space, if in "staged" state, no other user space agent can
>> access the IMA measure list, right?
>>
>> Could you explain the benefit of bringing the "stage" step?
> The performance improvement is because "staging" the IMA measurement list takes
> the lock in order to move the measurement list pointer and then releases it.
> New measurements can then be appended to a new measurement list.  Deleting
> records is done without taking the lock to walk the staged measurement list.
>
> Without staging the measurement list, walking the measurement list to trim N
> records requires taking and holding the lock.  The performance is dependent on
> the size of the measurement list.
>
> Your question isn't really about "staging" the measurement list records, but
> requiring a userspace signal to delete them.  To answer that question, deleting
> N records (third patch) could imply staging all the measurement records and
> immediately deleting N records without an explicit userspace signal.
>
> I expect the requested "documentation" patch will provide the motivation for the
> delayed deletion of the measurement list.
>
> Mimi

"Staging" is great on reducing kernel IMA measurement list locking time.

How about just do "stage N" entries and then delete the staged list in 
one shot?
It means merge two APIs into one API
     int ima_queue_stage(void)
     int ima_queue_delete_staged(unsigned long req_value)

The kernel lock time will be the same. And user space lock time will be 
reduced.

Thanks,

Steven

>
>
>
>
>

