Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111810;
	b=CSYmISTYQ3p0Ax+9NOrUKLfluQRFlGDzvNaMtkGr8WU01vsK5H4X/Y0vwBde0ei9gLqp
	 OWVoGmCE3eXsJmpZ/dVf6iWoTBqLYK792ffQDqYJUia98BshM42swfKsSmCKqtlCOyJAb
	 BioLo03asGdK1mJzi5ldIpfpsPUuc4Q1nECWS5q9lyRk5IFTrxZT27MiP1duTHRTDaAE/
	 Vh7GmpEHYNcVQ7FFlqpsBvOKqKDBkKgAt8/KYTZbF/ntI/xYfFPL4868xiEVQtxKTJqp1
	 5Bkw/E/Fmq4RGIcjIMwGyt3SyrVYxJrObFEpKEsLymL5xGbtTY+emrA3yz8gEbcMxEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111810;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=DDw7CAOzeMjZ87nEGcA3ulwTRmsKh58E4v2DnTXYC5A=;
	b=D3nV4nMwjhQ+mvTR8bA644parjsB/5Z1+Zomay/1uA4dhisw5nnY9i/4+JRbW5O6pl3n
	 tYJJ10+pyau95dQjaF5/2tyfrkcm+1pNhth/0qIo7tWZ+gmWct+wEFZ6/UbzuvWDFQAfa
	 1dmwJ3hHvQR9TQyQWolLxLIxr8W6P/Dojyr+emOmSHhoYzdf8CmqWJuYEOg20dGE7PAET
	 kicC9AzU8CjxiKVOEas0rJMuByQHcI+ggfVsQSEVwXZC7GdifHZ612PGpKvIqiwvtfKGX
	 CaSygyvTWL+LxRYGppkU5wQ9z84zDXUT6GZMe3yRMkcuwktm8C8K7wZoq3McYRiHHCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=J5xjzEEG;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB5606A322;
	Tue, 27 Oct 2026 14:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAFB5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=J5xjzEEG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DDw7CAOzeMjZ87nEGcA3ulwTRmsKh58E4v2DnTXYC5A=; b=J5xjzEEGoiDDRIjOhbFvPXOve4
	OnXjrVTV7vyOkmrrB4N6aA8XD50a63Ushxk+3Be3pv9fkwDlpi7H+jAiasxMDfRcmGrUUHqlJl23G
	uQHbMDYGPG1LOrcUeVBauXpNQLXqzZ9f7zj931x6zOfySUFZ5NCrxHqmMM0tZ9+Kyr0NtTz1pCWMT
	ZM2B9/7qXSL6emdlc4Bv4s5EphfIebkCuwukdNb9U5REr4Zr7UCAN6D3grO6xNhsfwo0ML83i1s5r
	57XNKpSB6wsndrmbJoHr/QhilfWFhdVUOXzi1/jbBbyyqjxvQv8k46mpxhEybCaygasr4kQOwQOML
	CSvCIOoA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLiIA-00016k-0r;
	Tue, 27 Oct 2026 15:36:46 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLiI9-000Omo-0U;
	Tue, 27 Oct 2026 15:36:45 +0100
Message-ID: <96db3a96-0fa2-45e1-a981-ed377e5b21b1@iogearbox.net>
Date: Tue, 27 Oct 2026 15:36:44 +0100
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
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
 netdev@vger.kernel.org, stable@kernel.org
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
 <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

On 10/27/26 10:24 AM, Christian Brauner wrote:
> On Mon, Oct 26, 2026 at 04:31:25PM -0400, Paul Moore wrote:
>>  From what I'm reading the LSM framework patches don't meet the typical
>> LSM criteria for stable/RC fixes: there is no serious bug/panic, and
>> there is no functional regression from a previous release.
>> This looks like one of those unfortunate circumstances where a new use
>> case wasn't tested thoroughly enough before the merge window, so it
>> can wait for the next one.
> 
> My original patchset had a selftest that excercised the BPF LSM usability
> extensively. The hooks are new this cycle and broken for the main use-case I
> wrote the patchset for.
> 
> If we don't fix them now they need to be backported next cycle which I'm sure
> the stable developers will enjoy.
> 
> Curiously, your pull request told Linus "I expect that BPF LSM developers will
> also be making use of the namespace hooks, if they haven't already". So it
> seems very strange to claim this as a new use-case.
> 
>>From my perspective the timeline looks like this - I'm sure yours differs:
> 
>    I wrote an implementation for the BPF LSM to use a set of new hooks in a
>    subsystem I maintain months ago.
> 
>    You rejected the hooks because BPF LSM programs cannot serve as justification
>    to introduce new hooks. Only in-tree LSM (selinux, apparmor, landlock, etc) can.
> 
>    I cannot fulfill this requirement because I neither have the expertise nor
>    the use-case for any in-tree LSMs.
> 
>    Landlock wants to make use of this by pure chance. So the maintainer offers
>    to take over the patchset. He does.
> 
> End result after more than two kernel releases: The patchset that ends up
> merged into upstream doesn't work with the original motivating use-case because
> all the BPF LSM bits got dropped. So far, no problem. That may happen as long
> as we can the fix it rapidly.
> 
> Then I take the time to send this series of fixes to actually restore the
> original use-case so we don't release a kernel with a new api that doesn't work
> for the main use-case I developed this for.
> 
> Once again, I get told no. This time because the functionality isn't broken the
> right way to justify a merge-window follow-up. Instead, we'll release
> half-working functionality.
> 
> I'm really on the fringes of this endless debacle but this seems to be another
> iteration of "BPF people don't get along with LSM people" therefore they make
> each other's lifes and that of innocent bystanders that just want to get work
> done difficult.
> 
> I really don't understand why it's preferable to release a kernel where the
> original use-case that I was forced to explicitly abandon doesn't work and
> there's no reliable or cost-efficient way for userspace to detect whether the
> hook works correctly.

:(

+1, strong preference to ship the 8 patches as PR given merge win is open as well
right now and to avoid painful probing complexity in user space. Patches look
reasonable to me, and I gave them a spin locally as well as we need these too.
Feel free to also add for bpf side:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Daniel Borkmann <daniel@iogearbox.net>
