Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEB1E536;
	Tue, 19 Mar 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833888; cv=none; b=BimD7jX7VkB2vMawPQ67HucIUghsyVe/6WIXbrENEYX64P+Q8fFQQX3ijyKIkdYFZY23X8LhOh35f0+1U9K0hi93L8ZbbJEKQhU4y2HFgKV7ltgwfstMIMy8AsNFV1vG6nvQUVM6EvtiAr/v1/qx8aOHLI0pTXXcwsRJh3D7Bkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833888; c=relaxed/simple;
	bh=En+ooZKFXtq9+muJ/fWXjT5nz+yfsXO5o61ppq7jfaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQRxpal0RVnkcKO5fCyjJRDvTOK0bXdfdoNa3nM1HOgzALeZD7HxK0rU4rqd6puNlWAQWrMiXFagHU/ysJvAe/+hFDtoGHNLevOdLWHrySvWnhucyzbvSrHA+B9Yewpo4W3TfffUWTHJWwTaMTjhpY9fgwoQ6bbr3XJJD1co5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzNqQ1ml5z4f3nK5;
	Tue, 19 Mar 2024 15:37:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 22CEC1A016E;
	Tue, 19 Mar 2024 15:38:02 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgAnQgvXQPll3vSoHQ--.5350S2;
	Tue, 19 Mar 2024 15:38:00 +0800 (CST)
Message-ID: <2189be97-1bc6-4777-9ecd-41bec17f769a@huaweicloud.com>
Date: Tue, 19 Mar 2024 15:37:59 +0800
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
To: Paul Moore <paul@paul-moore.com>, Stanislav Fomichev <sdf@google.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
 <ZfhxRZR9ejNt8mgN@google.com>
 <CAHC9VhRKV1ATqkCdFQeSQpDc4znuZhBf_=GWuJ=zB=n4_1yYxg@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAHC9VhRKV1ATqkCdFQeSQpDc4znuZhBf_=GWuJ=zB=n4_1yYxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnQgvXQPll3vSoHQ--.5350S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW7Wr17XFyrKw1fZFW3GFg_yoWDuFb_Wa
	ySyasrGw1DJa18AanrAF109rs2gFyUJryFvay3Jr4Iv34fZwn5Jan5Gr93G343t3yxAF10
	yw13Xw47tw47ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73D
	UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/19/2024 12:58 AM, Paul Moore wrote:
> On Mon, Mar 18, 2024 at 12:52 PM Stanislav Fomichev <sdf@google.com> wrote:
>> On 03/16, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> A bpf prog returning positive number attached to file_alloc_security hook
>>> will make kernel panic.
>>
>> I'll leave it up to KP. I remember there was a similar patch series in
>> the past, but I have no state on why it was not accepted..
> 
> I believe this is the patchset you are referring to:
> 
> https://lore.kernel.org/linux-security-module/20240207124918.3498756-1-kpsingh@kernel.org
> 

Thank you for the reply. IIUC, the above patchset is intended to reduce
the indirect call overhead of bpf lsm. I have tested it, and the panic
issue still exists with this patchset applied.

> It wasn't that the patchset was accepted or rejected, it is still in
> the review queue as there are higher priority items being kicked
> around in the LSM space at the moment.  It also wasn't a pure bug-fix
> or feature patchset/patch, which muddied things a bit.
> 

