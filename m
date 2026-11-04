Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.75.44.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759157;
	b=Vn7Vpcu79MJFpeEfGYlb1pcSGnOoDJqci50uEXb3lOGBH58yJ7gQyBzmBDWCqqs2Xtv8
	 47e5GboQkXGijL/A48BNKudDJ1U2TJT8srFxJNWslNcBFHb+btSv5bxMHj51gr9V0va/m
	 3IcfeUjpWH6kkGnGpc1E8wufgXwE/xa/mkV5j7tN5FikFmyTw2wWvol1ZfcturBHdAv0p
	 niaOagaAvyjTGmLnJmhT3rW1hthCPtdOHkQ0AXnT1aUcImuLO1gWj49GeDmpkhSZ1z2Hk
	 b5gXfpbeFLUs/NA4nj/kfJu0NfARVb+0zfbADTv/o3JHqPX09BLWeW5VdUjDhkEDsSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759157;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=HhUw5YLUukraJ9A5Hj83RTutdKmDXAieilZGGjQwU1U=;
	b=1Wa08oQKnyHCcZVNIs+lWXAdLxb9MtUyiWzvClsznRUrm/G/BfOHHcth7LvHCBSBeGfs
	 WmlIVhtcZ6fxtbpc+JaTJXe34Xc4GkumAK5AOqc89zGICys2UE/WIuEtYQ2EGMHiE0Ec5
	 8RqxTGASUxLyHxNOMsVk//reanVHSMwIzmmuQquAr83yMcBL7mflbVKZAQsd/fEmBCNrQ
	 xi9TUoODdPhLEOSGaNL36NQK4PGn2XX+lo9wthwMes+AVkyYAMoomBw/BlqYNaMT0evXV
	 W1pO0ErT6wJE2Eb3VZr2tMheS/i7yUPMyvMPDZi+m4agZzWZXTO5tUJA7IQBsUsiuew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=13.75.44.102
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00440606A31B;
	Wed,  4 Nov 2026 02:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00440606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with UTF8SMTP id IQEQrMD2HXeol+pqUXtwAA--.31840S2;
	Wed, 04 Nov 2026 10:25:44 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wDn0Dail+pqcvIYAA--.18318S2;
	Wed, 04 Nov 2026 10:25:40 +0800 (CST)
Message-ID: <6c2103dc-4eec-4b70-9b68-6fa907bffcc4@hust.edu.cn>
Date: Wed, 4 Nov 2026 10:25:38 +0800
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
Subject: Re: [PATCH 00/10] docs/zh_CN: add LSM admin-guide Chinese translation
To: Yan Zhu <zhuyan2015@qq.com>
Cc: skhan@linuxfoundation.org, gnoack@google.com, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org, alexs@kernel.org,
 si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net
References: <tencent_001080DF135CEE2CD1B260EFA08E3CC71A09@qq.com>
 <tencent_7F10C2E7BB9C4B842554D6E95DE5D1DBD806@qq.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <tencent_7F10C2E7BB9C4B842554D6E95DE5D1DBD806@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMD2HXeol+pqUXtwAA--.31840S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xAF1kGr1UJw43ZryfXrb_yoW5trW3p3
	Z7KryfKasrCrn3Grs7CF47XFW7tF48G3s8K3W3t3WFy3WktrsYqr4j9ryqgFZxXr48X3W8
	XrW5KF1Uuw4UZrJanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQCb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	rwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUsqjgDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 10/24/26 11:07 PM, Yan Zhu wrote:
> Ping
>
> On 6/12/2026 11:58 PM, Yan Zhu wrote:
>> This patch series adds the Chinese translation for the Linux Security 
>> Module
>> (LSM) admin-guide documentation, including the main index and all ten
>> sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
>> ipe, and landlock.  The admin-guide toctree is also updated to list the
>> newly translated LSM/index.
>>
>> The original English documentation was restructured into 
>> reStructuredText
>> by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
>> and each sub-page has been kept up-to-date with subsequent mainline 
>> changes.
>>
>>

Hi Yan Zhu,

I have replied in the single patch thread. Please double check them and 
reply there.

Dongliang Mu


>> base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git 
>> docs-next
>>
>>
>>
>> Yan Zhu (10):
>>    docs/zh_CN: add LSM/index Chinese translation
>>    docs/zh_CN: add LSM/apparmor Chinese translation
>>    docs/zh_CN: add LSM/LoadPin Chinese translation
>>    docs/zh_CN: add LSM/SELinux Chinese translation
>>    docs/zh_CN: add LSM/Smack Chinese translation
>>    docs/zh_CN: add LSM/tomoyo Chinese translation
>>    docs/zh_CN: add LSM/Yama Chinese translation
>>    docs/zh_CN: add LSM/SafeSetID Chinese translation
>>    docs/zh_CN: add LSM/ipe Chinese translation
>>    docs/zh_CN: add LSM/landlock Chinese translation
>>
>>   .../zh_CN/admin-guide/LSM/LoadPin.rst         |  33 +
>>   .../zh_CN/admin-guide/LSM/SELinux.rst         |  45 ++
>>   .../zh_CN/admin-guide/LSM/SafeSetID.rst       |  82 ++
>>   .../zh_CN/admin-guide/LSM/Smack.rst           | 722 +++++++++++++++++
>>   .../zh_CN/admin-guide/LSM/Yama.rst            |  71 ++
>>   .../zh_CN/admin-guide/LSM/apparmor.rst        |  59 ++
>>   .../zh_CN/admin-guide/LSM/index.rst           |  46 ++
>>   .../zh_CN/admin-guide/LSM/ipe.rst             | 723 ++++++++++++++++++
>>   .../zh_CN/admin-guide/LSM/landlock.rst        | 169 ++++
>>   .../zh_CN/admin-guide/LSM/tomoyo.rst          |  63 ++
>>   .../translations/zh_CN/admin-guide/index.rst  |   3 +-
>>   11 files changed, 2015 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/index.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
>>   create mode 100644 
>> Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst
>>
>

