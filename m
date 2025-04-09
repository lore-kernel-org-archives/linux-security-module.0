Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D271DFFD;
	Wed,  9 Apr 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212175; cv=none; b=BeoMfYr8BOurpN3hLw60yROh8+qlcu2FAQAHjDvQhYkjf5LOknmZfKiqr+tj4LLk7lKW0kI/GdDOg+79Zjs7woyiamu5GS/yJguWN04s8WNinMK0nx8aCxGGDOGdFstakWvZTXOhqapq7xPezRBqYNQDlASVXTbO+ajVH2hRF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212175; c=relaxed/simple;
	bh=oHhieYQ3u7Cu2t63oLzNOJtR2CvzcHlG6+SSCnb0daE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qp4PPY5aTP+eCm3ZXWvb71sBC56LMnOVy+mENd4IzTGrFTRS1wr6NVoLbPuYmRnyrI13xIIsakWfEJHPpvnOR9qG22qzCf8NgR0HVUdLuYy425yn3WYVPk7Pn7gidPfDiGQbIXB4RuO2btKcWxPse7QznkKdmLwLswmoxRJz36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AOmDrUh7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPuN3Mpt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AOmDrUh7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPuN3Mpt"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BE95F1140103;
	Wed,  9 Apr 2025 11:22:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744212171;
	 x=1744298571; bh=yuZmCfMgXvUIwnN64SS6KHwYGRZR2iDiBQ5BByDgfC8=; b=
	AOmDrUh7XyQFaF71lhNUncQsvyBm47GhwBH4kyZMcnkf32xsGlUC/3wrupVT2/Xw
	a8X8UGLuY50Oik+Oh41Swd3x22bhopkiHMZdMdmuohXMzFYbxCsHvpIQtHxEGUsx
	3Ebx9upr4MxF6EofMqgER6GiUHFCiVTlJmTDSlvrLNaTPfW2MRpL4SuC8ovUnXcD
	dZ/iCWOCVFZ3nETKSIivJ6xrEAsN9x3U3HoKjvk+wPvuVnhM5y7Atg3y+LATJqaM
	qydic/ZF0Lc7MmIW3TezxPkeSzObNrhV6ei9XGU2FEugdub35EXsbV0o2TWsEyHl
	7/5pvclCD7c9IiNOS+WdVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744212171; x=
	1744298571; bh=yuZmCfMgXvUIwnN64SS6KHwYGRZR2iDiBQ5BByDgfC8=; b=G
	PuN3MptOcgZsxMfLQo58bRd2AMCrUesuWg/eku17kgi8FLV60UZNVpoqKaE85qww
	awPEoUz10vDSVfnOmj+1qgBiWRDN9Q6FEJQrD1PLxClB5XuLRUddYUc4dLqStPkg
	sXp6sqacS9nyL7G5sPAAaq204VOCg3rPYq7V1BBIOTrkrS69uVBoB9Ac+BWTbY2G
	kaBdyCLjJGIouCsS/szBeutxGB2Rt44F18+WRTa74nKyWHkwa60pLNIZ34TlEJ+B
	ASdcbOxW4L0roj/CfXe7nQbgWxhdDqiuiZNzk7W0hp5/oWcK7XvOBJWtDX1hWQop
	dmsgn/Hgh6fVGMu6a9bzQ==
X-ME-Sender: <xms:ypD2Z2hFzCQmWNRxy5wrLq3ZRWrIKEubaDQJSQZtU_rbOgpYdo59ag>
    <xme:ypD2Z3AZK6Wr1AXl7Uz37-aICMvPpa25TTFr9wU7flGxlnEa_jYqSl634x1THxuye
    WMZol6ZeRsx96skosE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggt
    khesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtoh
    hmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhushhtrghvohgrrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhmohhrrhhishesnhgrmhgvihdrohhrghdp
    rhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqhhgrrhguvghnihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ypD2Z-HM1Jaauxrekc682Rtj3ZlKjI-kN-NFgTtRAekkCKy6usoaTA>
    <xmx:ypD2Z_TN_Kq7WORQXyjLWgLeVHbV9BK-KAGkn-mXmtszLe9MDXAL6Q>
    <xmx:ypD2Zzyt4J_OaP0dS0q8U7N2CH5sEMt1IglS6wLzMz748xrn7_FXwA>
    <xmx:ypD2Z95GhCo_c5_jGbyZ0h-JyyAB-sbu7qbEp7mLk4I3Lj9n0r9TpQ>
    <xmx:y5D2Z5DQnlum0O2xoKsPYQTUqYsQnat8Z0-A3qb7hBBSYGAN4QhwdUyn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9595F2220073; Wed,  9 Apr 2025 11:22:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T281fa94f3e1ea3ab
Date: Wed, 09 Apr 2025 17:22:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-kernel@vger.kernel.org
Message-Id: <37bccc57-01b2-46ab-b973-ad52590f4ca2@app.fastmail.com>
In-Reply-To: <20250409151154.work.872-kees@kernel.org>
References: <20250409151154.work.872-kees@kernel.org>
Subject: Re: [PATCH] hardening: Disable GCC randstruct for COMPILE_TEST
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 9, 2025, at 17:11, Kees Cook wrote:
> There is a GCC crash bug in the randstruct for latest GCC versions that
> is being tickled by landlock[1]. Temporarily disable GCC randstruct for
> COMPILE_TEST builds to unbreak CI systems for the coming -rc2. This can
> be restored once the bug is fixed.
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: 
> https://lore.kernel.org/all/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/ 
> [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
