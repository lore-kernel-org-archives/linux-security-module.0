Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AF274B23;
	Fri, 10 Apr 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785511; cv=none; b=Z8P5ZR7n5g/YJdZDEDSBTWvnX754Z4VSmCpRSZuhVYvL3vWlHj++2mO+96cbL1gmoi8ICO8JPRL4skBxsZC9rcAFll8av16kL8FTFzyTjzhcgEL2FcJ5O2GRwKvYYfn1DctMptNRu6vWLOd+zZmRZue2b4gtT8QRbdk6aXFYQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785511; c=relaxed/simple;
	bh=Neeii8zrl1ugmtb76zd2nnWrxnSSUoTT1BzhPC7YXV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIgsOxLFOY5efXnN2Enr9AWKasQsvEdJ34AnYlFPRVxP94Ii98KFXPoCn/PqNez+6J9sd7O0vNiMXojygwY+8Nqv/lgo050jw5mpv4wBpgFrMGWRFSaks8/SUqxiSmTzV1L4Jm37XvhBfYx6ELwcUWyrnlkfeNEObFdcfUNzjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=C2e1bmx0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uK2J00GJ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="C2e1bmx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uK2J00GJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A15F51D00114;
	Thu,  9 Apr 2026 21:45:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 21:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775785508;
	 x=1775871908; bh=6NwyPCyHaboSEWdcitdJmN8JzYLSO5FAnnQf1Yhqdag=; b=
	C2e1bmx0RE4aYSqt5wsDwUB16tz/Nr/7VXhU6or7vPQlK5ZzE2bNFmOhdSo2b5qs
	itYbTNs4HFRuYosW5/bJMygvZ4SORmR4r/FHmA+iTZfu1JWOs7qkkISvuiQakoyg
	ZtwkrZEqabE0LOipQo/ZSYVLtg9e6/5QjLzThJ1hQtoZ8Uje99atNvJL02k27/zu
	B1eDwV7YfCq3SrwBp5XNzT4ws8C+faCdHSSmCLgNWkfzCFcpAaWlTS/uwWj2DNGp
	F3RZqRfA7tz0wkn5O2i+Ahac+6+dLvnPJmexoqxQ+C3bX5bYDdN1nuC2+XEsIyTM
	5cT++xxbTiaN2D9yqT2bbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775785508; x=
	1775871908; bh=6NwyPCyHaboSEWdcitdJmN8JzYLSO5FAnnQf1Yhqdag=; b=u
	K2J00GJJh2PFhd8cSi40+MtRZngi++anlOiDAFui9sRiKHm+PA3C++u0Ff89Mw7L
	SI+c31DcUsTyBKBcLm+ncXNqVYPFifNkYhTY+s8D2vOr6HCJ117iRz5chxRGmZlm
	ZubWCcTtEfmVGImSGtDpF96HPq7U8VSex1y2dAC1gRa+V67KuLj2pVBe7bwKpSKB
	KMiFG5HuPYI4Us8Tow+nWnoqD1Pq6X+DHkCCqZyX6gwx3Xleto2WD1jKbLyE+yAM
	2584npdts98LhT4QUDIC4WKz6gCLTGDFlfLYbOKi16Lu9nhZf7Rww7Y+lutmDG3X
	PT7VNNXH2MDS7ytCamhbA==
X-ME-Sender: <xms:I1bYad_IEvk81Z3eu5ri98yVn9voExSWe1k4Ssjq1UhoRucxt_CUeQ>
    <xme:I1bYacH1QAR0_Ush4vWlz6bkRjlBtJypbIFiTUNFShat7yc-C688gbZHpnuVCXj1u
    S1b6LZuvNKqeuzLsYD2QX12xf2d0gNa-rj0AGQi3r7epbFTZKGCyU_g>
X-ME-Received: <xmr:I1bYaRKpJsXQw5ueeS6Fj9Rz7Oaa3dxTNuv-Z0D1AipAr1dndnW0uXVWgdAA0BNi46AsFoeJK3GHcLMxzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepsh
    gvrhhgvgeshhgrlhhlhihnrdgtohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhej
    jeesghhmrghilhdrtghomhdprhgtphhtthhopehlvghnnhgrrhhtsehpohgvthhtvghrih
    hnghdrnhgvthdprhgtphhtthhopehivhgrnhhovhdrmhhikhhhrghilhdusehhuhgrfigv
    ihdqphgrrhhtnhgvrhhsrdgtohhmpdhrtghpthhtohepnhhitgholhgrshdrsghouhgthh
    hinhgvthesohhsshdrtgihsggvrhdrghhouhhvrdhfrh
X-ME-Proxy: <xmx:I1bYaclMW0FzflK1uUWR-ENmJWbA-YDrSWBVBscA43gMtIUcCwc7pg>
    <xmx:I1bYaaxMU4b4ZXDaRudCoXprNlKVW2i8dLNTgjd6jpdeckk6k1xBEg>
    <xmx:I1bYaWuglBI2U9aecGKR528_HHQmC8oSWr67bnpEAyj0HusxXiHgdQ>
    <xmx:I1bYacHf7344_zotsE6sqWCE3pJr89iUBNd6rzwk1xCUdiNwnPXY5g>
    <xmx:JFbYaff0_46KNmTSlmuiiv0NbocrNPy4JWPBdGYSVHN-vyDl7Py9I_q5>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 21:45:05 -0400 (EDT)
Message-ID: <c39bea2a-2ed4-4f71-bb19-8669a4e1b072@maowtm.org>
Date: Fri, 10 Apr 2026 02:45:03 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/11] landlock: Wrap per-layer access masks in
 struct layer_rights
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, Justin Suess
 <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Shervin Oloumi <enlightened@google.com>, kernel-team@cloudflare.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-5-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260312100444.2609563-5-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/26 10:04, Mickaël Salaün wrote:
> [...]

Hi Mickaël,

As requested I have reviewed this series.  All looks good to me with one
minor comment on the next patch.

(for patch 4,5,6,10)
Reviewed-by: Tingmao Wang <m@maowtm.org>
