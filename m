Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794899305;
	b=UJiRWMgvDmNm9Vf8Abosc5xyzikAaWiyR4WE6nKEZF5gqQELZVjuu5EwHgQOL+7v4bDG
	 ksYp+1CK/JirIlqUATuO5lcxMpjunBJlcB+RwzkGPJGZZ7GYY1oJccJRQnG2OlPptYj9/
	 XufjnJXHFbXVzR642/9u6LQcD3BGf2B5pwYsGSCspDWamQ+v35ehiRzD0+YmhUsSbsK7/
	 bP9k+8uOX8qiAorelWscx/5BHZw7zDqt0WhaZ9Cly+li6qRI71edBDRc9Go2iRNajbFId
	 dfedoaYrOc3GR6F5Cowz2+VzCbg1H7bzdoIQxywJ30jIdag1WgpclkUQoS8irAmmYDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899305;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=rOa3RtnmIODQAIOd/ZqlGYqJucQki9cfsWeLmMaO4dU=;
	b=I8o4h5RpekShu7K1lvGzra7ljEs7yUzkgTbpBw0sMwnEZaLS7GbKziQHXrIAj0slrwj2
	 8gcMLEhBaAP8nkkyOVmIvJsF2bBgXPcyXS6Xj8ts61aPyrXnQxebbWxa1ZMKYJtTI1Tlt
	 eU7j7l0z521+rNFKKuLZvvoTWQhGwrgtbHvxKoaR4N29bw9+s1deom+Ay01iq0i4fTgmS
	 fW/y/BylbhrGDLCL1zWXGnsyIx8inhpcmcrwpCCu6Arm6ec/mIfSTNIY08+qwBPVc8zDN
	 QwgZd1YVx621j6Qr7550J7Tga5NUspSYESX7NJ26GyUd1fAmLe/BWaZQVxmzpabxxLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="L4X/7pi/";
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832E606A329;
	Tue, 17 Nov 2026 07:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C832E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=L4X/7pi/
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rOa3RtnmIODQAIOd/ZqlGYqJucQki9cfsWeLmMaO4dU=;
	b=L4X/7pi/hKgrcWH+r2Lyz2K5fDr6oemmr9Vqo/mlPjixIKI0SaWd02EkAFwLiATXCcyx1b0Xd
	SD4a44BotoB4mvpr9tipicm36JCDbfzpc2xS5upFF+YfPk1QhGsg2JAQ+C8ME4u4aQkhKCrxCFx
	b96PIsaaZyFGx0HZvwo6Js4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jTG5y5hW3zKmT8;
	Tue, 17 Nov 2026 15:08:06 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 72C8D4055B;
	Tue, 17 Nov 2026 15:08:20 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:08:18 +0800
Message-ID: <ece02e4c-f87e-48ca-a653-cd02ca74eaba@huawei.com>
Date: Tue, 17 Nov 2026 15:08:18 +0800
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
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
To: "Serge E. Hallyn" <serge@hallyn.com>, Oleg Nesterov <oleg@redhat.com>
CC: <kees@kernel.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<alexjlzheng@tencent.com>, <jannh@google.com>, <jaime.saguillo@gmail.com>,
	<elver@google.com>, <blbllhy@gmail.com>, <bvanassche@acm.org>,
	<pjw@kernel.org>, <broonie@kernel.org>, <debug@rivosinc.com>,
	<tglx@kernel.org>, <aleksey.oladko@virtuozzo.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <morgan@kernel.org>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
 <atjN3JX7sWx9kpQ5@hallyn.com> <avHfm5/mVtuN/oPW@hallyn.com>
 <avIKUzCKAkfC-wuk@redhat.com> <avIVCf1ok6Xyfii0@hallyn.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <avIVCf1ok6Xyfii0@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/11/10 2:46, Serge E. Hallyn 写道:
> On Mon, Nov 09, 2026 at 07:00:51PM +0100, Oleg Nesterov wrote:
>> On 11/09, Serge E. Hallyn wrote:
>>>
>>> Hi Oleg,
>>>
>>> please see below.  Do you have any issues with this use of sighand?
>>
>> Hi Serge,
>>
>> I already tried to look at this patch, but sorry, can't really comment.
>>
>> I'll try to take another look, but can't promise much, I don't understand
>> the problem space (I could never reallly understand capabilites in details).
> 
> Thanks.  I'm mainly wondering about the storing of this pending capability
> bounding mask in signal_struct, whether that might have any unexpected

Hi Serge,

rlimit is also placed inside the signal struct to implement
process-level restrictions.

I think the different lifetimes of cred and signal struct might be an
issue, but since drop only decreases and never increases, the result
seen by the user will only be stricter.

Link: https://lwn.net/Articles/103658/
Link:
https://github.com/torvalds/linux/commit/31180071ee5e6cc6ff4d036d655c556f582f74e4

Best regards,
Jinjie

> side effects.

