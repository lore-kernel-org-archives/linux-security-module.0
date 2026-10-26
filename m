Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006796;
	b=RPol7OScPaWnRzR+yXU0okDQFImAPdVWpITrmOTt/9OlL3E8mqYFxTvnGA5uX7sa0dJJ
	 8n/iJCBAXMB2Y1oQvwDDInEYiz1DoNctF+sDOzE/kbgIPFP0hP9ymR1TS54ycBedjdRK2
	 O1b1IjmI05D+V/CAbXmg79WhoTZB8EVsW2NZf2uciO23ovjDXSHA9ZLL2R8Zy/qF5UBVr
	 pETDa3gFNJ/Qe95SvJmSKHGnuFF/jFtehHkIuOMLuYiMSIvWVv6oORE5E2sgJdcXXhQQ6
	 6q0GqCpM/2zSc2if/vxHqHOvUntRP1w6wX8OfIta83E7o3pBgv/DUzgMhI5tzVvAFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006796;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bMfgjD0fUY2u4A6RwbN+yTCX4OmWey+xYcDwHWVZBDo=;
	b=YNag9Zd4pMsH59USjEXSbTQiK7712XYXWlQKbaOASoFXzzNoSCcIMPGzVzqaLCyEd70I
	 xANnuSZuliBj233pJ+ywEv8dODXs8bLlEGvbFGuQ5HHsrnc1eQFhRHbIwh2aMQ+zzoZLc
	 Z+jetYodQR8aAi6szKq+J/c2kVlLVf4nQ2P+YbNqGKUH8MpzgMYfuXvStd3QJTr/aLvVn
	 EwkCtYkpj6w717MWxqUMnL5uNqrxejv7bPKckptUhpq82kyxmeXWQYkO0SRcwEW11s71D
	 HPWBeh76VdYqbajNit/pr9puutMzQyFT3LIoWSC9WNbetbrl5TQ4LH1okeLOEu+E77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777FB606A31B;
	Mon, 26 Oct 2026 09:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 777FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with UTF8SMTP id IQEQrMBmj3jBHN9qqZFcAA--.53078S2;
	Mon, 26 Oct 2026 17:26:25 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wAnqyy_HN9q0H8PAA--.30430S2;
	Mon, 26 Oct 2026 17:26:24 +0800 (CST)
Message-ID: <440378d6-d72c-4edd-9159-582df02b49e6@hust.edu.cn>
Date: Mon, 26 Oct 2026 17:26:23 +0800
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] docs/zh_CN: add LSM/ipe Chinese translation
To: Yan Zhu <zhuyan2015@qq.com>, Fan Wu <wufan@kernel.org>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net,
 skhan@linuxfoundation.org, gnoack@google.com, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <cover.1781105672.git.zhuyan2015@qq.com>
 <tencent_DADDE291CA580302EB7BB40B83A552D6F006@qq.com>
 <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>
 <tencent_EF8D392378BF3BBAB8583E67EDDDE51E950A@qq.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <tencent_EF8D392378BF3BBAB8583E67EDDDE51E950A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMBmj3jBHN9qqZFcAA--.53078S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWrKry5Cr4DuFW8Zw45Gw4DArb_yoW8JrW7pF
	W5G3W2kan7tr1jyw4Ikr47Aw15KFZ3GrW5AFy7twnxJrZ8t3s5Kr12y3yq9Fyq9r1rWF10
	yr4jkr9xWrZ8ArJanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQKb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02
	Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0P73PUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/13/26 11:08 PM, Yan Zhu wrote:
> On 6/13/2026 10:54 AM, Fan Wu wrote:
>> On Fri, Jun 12, 2026 at 8:59 AM Yan Zhu <zhuyan2015@qq.com> wrote:
>>>
>>> Translate Documentation/admin-guide/LSM/ipe.rst into Chinese.
>>>
>>> Update the translation through commit d7ba853c0e47
>>> ("ipe: Update documentation for script enforcement")
>>>
>>> Assisted-by: Claude:deepseek-4-pro
>>> Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
>>> ---
>>
>> Have you tried to refine the AI translation? IMO some are really bad 
>> translated.
>
> I have double-checked it several times and manually corrected the 
> formatting and the accuracy of the translation.


IMO, some translation seems like a draft version generated by AI and 
without any further refinement.

Dongliang Mu


>
>>
>> Also how does the doc translation project work? I do notice there is
>> another IPE design doc translation,
>> https://docs.kernel.org/next/translations/zh_CN/security/ipe.html
>> which has a wrong "original link".>
>> -Fan
>
> The documents in the "admin-guide" directory are intended for both 
> administrators and users, focusing on usage; the documents in the 
> "security" directory are targeted at developers, emphasizing design 
> and development.
>

