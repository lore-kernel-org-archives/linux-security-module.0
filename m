Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=61.135.153.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053353;
	b=cCvNWIKJg8RYXtmnbGJwbzuow0vNt/6E4Nwe1bn4Qx/4n8NfLjYZ0eRpn6JBd9BwA/J5
	 IfIx5Rej32p31pj9zh4f34DkIP7uLNhpJGzjXtJRV9JrP3k1UxHMfqdg7yte2q1Lp4/Qr
	 ZeX/9JDJHULeIv4TJZm5v+PP/w2bJHLz2bby3oa1F/pucB7pyVNV0btE904JnsGjdBc5o
	 X0wb9fsYhMyYM3XwWPnuQn1549aN0XqpaCDti/wDwEPTQ9xU3XNAV+IfJ/llR+ZLzi17D
	 AaInvmNcC/QXEXaE4VywJQiott1HkSCE8/+IbrEQ44CSKD9hZ6U5aYoZAaUrTv16RHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053353;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5a9b9p/UJjslYubv5cdFdvvrFLpKyP+ZAkQDrroPyH0=;
	b=VccSIxzyFMNce1ZcU5U1HzjYucw3nx9Q7Z4h1AB3Z2eC9ryWMjIYsTfAvn17PaZQDEsb
	 Simq3q/GZ/80QoaSVz7h7cMetxVkncNVU6QNFPbjJuSSDAdGKw8QzkOAJ1hbxBAPjNSCL
	 +3TLHBwfOua525AylyFHJ04Maoq5xyX/jECLAPvLhcicdrcYWNqxhFWxm0cLDdj4W5HlV
	 bTC96o221MnJwE2ux3TQCZWPwYAI5ETZptR4K5DchwgTNBU4JJJ9EZWDvpQml0isTJKrM
	 gn6G3XM5zWLZg7jOLXoHhiCFn5F+OpLrIWvecutPP/vZt22VqKrBFClUgZJavYasxTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	arc=none smtp.remote-ip=61.135.153.165
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA48606A31D
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 22:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA48606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793053349;
	bh=5a9b9p/UJjslYubv5cdFdvvrFLpKyP+ZAkQDrroPyH0=;
	h=From:Subject:Date:Message-ID;
	b=KD5fVYcYHy3Bi+8QBhKrzW7zSjtJZ0jRwrF/+JkUxHf1b3ghL62xnvwfidlIMz6u3
	 Sk+9B8Y4h+t1zTHlZpqGzHNc/+yJBzEls0cETauRRKdnSAIYtzNvHI+tONnJyLZ+ws
	 Qvzafr8CZYfjwGcHnegZQODJADP02NxbE+PWuIwo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.116.161])
	by sina.com (10.54.253.32) with ESMTP
	id 6ADFD29900003C30; Mon, 27 Oct 2026 06:22:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5247364456895
X-SMAIL-UIID: B7C18B214B434382B1709165159D6EC7-20261027-062220-1
From: Hillf Danton <hdanton@sina.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Date: Tue, 27 Oct 2026 06:21:52 +0800
Message-ID: <20261026222207.1237-1-hdanton@sina.com>
In-Reply-To: <at-LgXM3BjyfF21u@kernel.org>
References: 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 19:18:57 +0200 Jarkko Sakkinen wrote:
>On Mon, Oct 26, 2026 at 06:57:22PM +0200, Jarkko Sakkinen wrote:
>> > --- x/security/keys/gc.c
>> > +++ y/security/keys/gc.c
>> > @@ -270,9 +270,8 @@ contended:
>> >  
>> >  maybe_resched:
>> >  	if (cursor) {
>> > -		cond_resched();
>> > -		spin_lock(&key_serial_lock);
>> > -		goto continue_scanning;
>> > +		schedule_work(&key_gc_work);
>> > +		return;
>> >  	}
>
>I guess I'll to elaborate my fix and this proposal as you gave feedback
>of neither.
>
>What you wanted to respond to my patch other than nitpicking is probably
>this sequence:
>
Nope because synchronize_rcu() has nothing to do with workqueue lockup.

>  key_garbage_collector()
>    synchronize_rcu()
>      synchronize_rcu_normal()
>        wait_for_completion()
>          schedule_timeout()
>            schedule()
>
>I should have put this to the commit message, and missed also this
>detail.
>
>So the way I saw this, which could be wrong, is that the workqueue
>lockup would could happen less often as also other threads are scheduled
>preemptively in unbounded queue outside critical sections.
>
The unbound queue could also suffer lockup.

>What you are doing with early return is at least not right as it 
>corrupts the state. So you should supplement that with something

How?

>that carries it.
>
Feel free to post a diff?
