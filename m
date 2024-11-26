Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B83208;
	Tue, 26 Nov 2024 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602448; cv=none; b=e1GnJzunVJPIhwO/tyCwtrbG8yafgaf48VLMxANlwwFzJmeLLytNbcyc1gU9cZ2obIHy9HUmaQ6l7MTabpuma8WPcytrdsLhr9XRczSMrlZkt6Fbq6biJbe5Sd99lxwoIqb19Uvy0nxxxi35tBn6OE/inaYnYc1s9xOMudpxvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602448; c=relaxed/simple;
	bh=UlO7t7b9uptyFYeH6BbOgjSWlkU5vvwVNEeLCtPAiAA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Cc; b=nJJp+ukJ3Oi6o22SgiiS5czPPQ/00mFs8cV11IoT8Ol59zBRkq7h0uH5yDEHyDVn0HEm35UwjUPMIh+VlDvZMPyzunGo6VMcO3i18L639d+MjuSImM5oT2DrAy+bBDTQyqcfCehuwWIrsSx8CIwp938MUOk7wjMIyJ4QTovOhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b=qVIOdvn/; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b="qVIOdvn/"
Received: from fidget.co-bxl (fidget.co-bxl [10.2.0.33])
	by wilbur.contactoffice.com (Postfix) with ESMTP id E9C316D4D;
	Tue, 26 Nov 2024 07:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732602443;
	s=20240605-akrp; d=mailfence.com; i=falaichte@mailfence.com;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Cc:Content-Transfer-Encoding;
	bh=4d2OucsJr+i4BIPoqG8I3DVx/83M6LVwokgDc0xnD1o=;
	b=qVIOdvn/eo+MJiJHppJvhgS+NCcrSzZCQtLmVlGXO7CZtvdm629KwDJcizSsfhDJ
	eCgYMjUHkMZNXdc2OQN0D3LmyR6a0JOKvpE8X3bTBFHoLShYwSlDQln4VcY6iAHtjHp
	HK8xTLe5k8zIeNZt1d8Ec7XDdyKN6l+UH8vvJQk/Q5p7bX0mwNpezxjjktXne60dMOn
	Vhz3NddVoHUaNO2Zv6V/C+suWFpHfTqeT5+5mgQWMfebmxFH1cmuWMjRrZ7qFw75cBm
	NdpiPsvCi3gnwi98osMoeu2K1MMS1+qEnPnse4Ehg5N5PMqWETabx/a8p5c2OnfGT+L
	dyA/VEq6nQ==
Date: Tue, 26 Nov 2024 07:27:21 +0100 (CET)
From: =?utf-8?Q?Dylan_=E2=80=8E_=E2=80=8E?= <falaichte@mailfence.com>
To: Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <1027126957.1379993.1732602441355@fidget.co-bxl>
In-Reply-To: <1592065022.1379875.1732602282945@fidget.co-bxl>
References: <Zs6jFb953AR2Raec@dread.disaster.area> <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy> <ZtBzstXltxowPOhR@dread.disaster.area> <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg> <ZtUFaq3vD+zo0gfC@dread.disaster.area> <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm> <ZtV6OwlFRu4ZEuSG@tiehlicka> <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq> <ZtWH3SkiIEed4NDc@tiehlicka> <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk> <6740fc3aabec0_5eb129497@dwillia2-xfh.jf.intel.com.notmuch> <1592065022.1379875.1732602282945@fidget.co-bxl>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Transfer-Encoding: 7bit
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:490142097

When do you plan on addressing the Code of Conduct violation done by Greg Kroah-Hartman and the rest of the Linux Foundation by banning all Russians from contributing to the Linux kernel and in doing so discriminating against nationality and ethnicity?

*Apologies in advance for not replying to everyone, my service provider has a cap on recipients I can reply to.

On Nov 22, 2024 at 9:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> > On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
[..]

Kent,

The Code of Conduct Committee received reports about your conduct in
this email discussion.

Link to email where the violation took place:

https://lore.kernel.org/citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk

Our community works on trust and respect and has agreed to abide by the
Code of Conduct:

Reference: https://docs.kernel.org/process/code-of-conduct.html

The code of Conduct Committee has determined that your written abuse
of another community member required action on your part to repair the
damage to the individual and the community. You took insufficient action
to restore the community's faith in having otherwise productive technical
discussions without the fear of personal attacks.

Following the Code of Conduct Interpretation process the TAB has approved
has approved the following recommendation:

-- Restrict Kent Overstreet's participation in the kernel development
   process during the Linux 6.13 kernel development cycle.

       - Scope: Decline all pull requests from Kent Overstreet during
         the Linux 6.13 kernel development cycle.

-- 
Sent with https://mailfence.com  
Secure and private email

-- 
Sent with https://mailfence.com  
Secure and private email
