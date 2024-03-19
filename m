Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21C1E536;
	Tue, 19 Mar 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834905; cv=none; b=ifAkSHhZ/+A9SJwoOHuLVZhxqRenMcQ23MbsjZeZjvrXfLDDwXIWQRcLu60SZjKYya6dTthb0/CiiHEUeVuO7dMtuZz7bl3vk8R8RpEi+J4TWMtEzizIO8vKKNkXyGyJqDt/liB6OGdtFZKqo4M1hklyPPv5cb5hNbhSxTDWJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834905; c=relaxed/simple;
	bh=J5VPP9bPh2PH1uj/X+2zJsp6dSXWy3N+VylzaFqWUlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcX19cFH3lnH74LzjpzGGKsFyKBRdEYYBRVq505WCHysf1Nk+YLaWFAwYwE8GJGEdgkHFttHM1YHmBDaRulrHJcI3t7WodbdY/gIUQjmPLhV7gnQTEz4kc1+f4exHXmjd6wKyh6gIYg65r/6ixNI78OE8qETfCqLjY6C1QMC2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzPC31DFxz4f3l8C;
	Tue, 19 Mar 2024 15:54:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 051551A0F37;
	Tue, 19 Mar 2024 15:54:59 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCXsQrQRPllAy6qHQ--.14400S2;
	Tue, 19 Mar 2024 15:54:57 +0800 (CST)
Message-ID: <1b9f6fe2-0876-48de-95a5-f15e5b5e9e75@huaweicloud.com>
Date: Tue, 19 Mar 2024 15:54:56 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] Fix kernel panic caused by bpf lsm return
 value
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Stanislav Fomichev <sdf@google.com>, Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
 <ZfhxRZR9ejNt8mgN@google.com>
 <2b49cd00bb85b7310db12014eea16c72d8a9351c.camel@huaweicloud.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <2b49cd00bb85b7310db12014eea16c72d8a9351c.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXsQrQRPllAy6qHQ--.14400S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW7uF1xJF1rXr48Zr45GFg_yoWkZwbE93
	yUA3srGwn5JF1xXF4xtF1a9rs7KFyUAryYy34UKr1ak3sxJrn7GFZ5Crnay3Z5G3yIqr1k
	Za4SvrZ7Xr1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n
	5UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/19/2024 1:02 AM, Roberto Sassu wrote:
> On Mon, 2024-03-18 at 09:52 -0700, Stanislav Fomichev wrote:
>> On 03/16, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> A bpf prog returning positive number attached to file_alloc_security hook
>>> will make kernel panic.
>>
>> I'll leave it up to KP. I remember there was a similar patch series in
>> the past, but I have no state on why it was not accepted..
> 
> Yes, this one:
> 
> v1: https://lore.kernel.org/bpf/20221115175652.3836811-1-roberto.sassu@huaweicloud.com/
> v2: https://lore.kernel.org/bpf/20221207172434.435893-1-roberto.sassu@huaweicloud.com/
> 

Hmm, these two series do address the same problem. Now I'm pretty
sure I read your series last year, at least some of the patches,
but I didn't think of it when I ran into this panic issue last
week. Maybe it's because I does not fully understand it.

> The selftests were failing, and I wasn't able to come up with a
> solution on the verifier side. I see patch 5 goes in that direction,
> and I remember there was related work in this area.
>
> (just saw Paul's answer, maybe the new KP's patch set also solves this)
> 
> Roberto
> 
> 

