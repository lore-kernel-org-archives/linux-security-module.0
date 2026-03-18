Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D73302742;
	Wed, 18 Mar 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854251; cv=none; b=pAtW14gvybB+OR7YY9407Rbhkx8vdyZZkjnHFU2sedEQMhpvog+xQmyz/WqhuC/j0R2U7onQ/qghCRUe7RznfTDGpJybHZbw6QXE/Ywb8VQtfXEEwoE9Jy5TzIs2rmaE3/s7vtllvxRBAIibt4SMaTKe7h8GdB2sPWbYrY6IvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854251; c=relaxed/simple;
	bh=6ZmAA5saERu+UJ6ecZfBA/F7FQNeG+OkL4BPl3qcQjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LdJfHHVGAD8GnicHx3FuEpVLQ6dTHu8cltGiy7TDkYYvN0qK7T9mzpVe/nt2nsgYps7nKFCVYCAqECNpD81PcED3TB1ESQ3YQu/npT2hynI9lRsEeMcvy5pCV/uEjNUiwCIxw7QZyvrnmapDOmCvfhjc6dhhE9Z4Q2tgLpPhc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Kxv75XlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6eWe1M8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Kxv75XlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6eWe1M8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E5A68EC0196;
	Wed, 18 Mar 2026 13:17:28 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 18 Mar 2026 13:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773854248;
	 x=1773940648; bh=djhjwgeq8iMdpcvt1BzD8WeuxR2brusPNPOgZFGdkBY=; b=
	Kxv75XlPvOv30tQMHE1w65N6xzxJ3UoLlfDhTBBOd8XeAQ7YhSZDNMl5e5uJ1O2S
	kKaeSrQvBpkPInT2TDzAWaa/wXs1wXS4oXk19MMmAq1DuGcDrgEMxJHYbG9e8nL6
	dcFS/j6YMGPvmGXatk19AoSf7e/i8MMyAWQ1V0ZSK6W+T/tMtFumTeQId08eYYtA
	7BoZEulEoLg7SlE+3EH6uA0PqxdTVdliL60fJQlrNPWKO6VQKjA3FnbYt2rubv9l
	n2nI0YxZv/LtXWkHxidFhrjTAY6izyoQjZg6HJRHOGtZDVAKOKKIqzuUp5OYxl1e
	LXbl5Lre45prnC+aAwgj8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773854248; x=
	1773940648; bh=djhjwgeq8iMdpcvt1BzD8WeuxR2brusPNPOgZFGdkBY=; b=W
	6eWe1M8/PY0akExRtRT0FFtXIZFHXkBIzavNNV9gPOC58ziNWQF+idaXEXCY84Gb
	bTmShj3Ddz9rBip6HtbxJsS+rRH5lKnuZqawGIo/YzCcarrudWpg7q6pMCvJaw5z
	Ltx+4C3PWdR2skq2LsxDRNT5HJVExnJdiWZyP9SNIr6N8j80McDJlfdeqpxJWfDX
	/BzUKJofGBwXbUUUTCGdxNIfR8M/4wAgB13JSNFTplMRvS7etOXcNXdSEAr+ygX2
	jFlwDotkni32w9kLfvWNxC/T/F2ZzJT8QE1B8zn/XCg01xpx/9IgR70nu12657lq
	zLofi+lqheZzqsCh8fqjA==
X-ME-Sender: <xms:KN66af4LGk2F8yTWx607eD703GNUUvNYuLYdbOvoUz-THeLNkontsA>
    <xme:KN66afsilGjCB5-jduDv3eu2JWqz6m0-HSjXt6UoZfF1M5cwrfEDVDdazHAewF7Bd
    7nkGZdrvvc6lmTVbKaapbqoDKqKjqKuJstKRmqE2kmAheTpZR1uNmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjohhhnhdrjhhohhhhrghnshgvnhestggrnhhonhhitggrlhdrtg
    homhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthho
    pehsvghrghgvsehhrghllhihnhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepiihohhgrrheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehjmhhorh
    hrihhssehnrghmvghirdhorhhgpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhr
    vgdrtghomhdprhgtphhtthhopegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomh
X-ME-Proxy: <xmx:KN66afhmd1tt7Aj30dJhsGinWhwMMdYT5BjrPOHsQ_t8gZDqVxN0sw>
    <xmx:KN66aX0SK_K1rlJbS9srxVkgRj9dx0kDTbFptL00iFHSRAQdy4ZK_Q>
    <xmx:KN66aadmgAiNfKE6rWQ5xRcngnQT4OMvhuQN8IuHIQgD_Y9mrB9t1A>
    <xmx:KN66aVz8h6EumUgOxzvINOtDEl7XgRV7idsys4F6n2eV7zNS8C-OYA>
    <xmx:KN66aZW7hAAluPVaxuY9nMnK17zU2MtTBPWl95YemBHa96fAl-JvHfeJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0026D700065; Wed, 18 Mar 2026 13:17:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHXfBdblsxk-
Date: Wed, 18 Mar 2026 18:17:09 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul Moore" <paul@paul-moore.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "John Johansen" <john.johhansen@canonical.com>,
 "Christian Brauner" <brauner@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <fe689975-a8f1-4370-b99a-b3456182ab37@app.fastmail.com>
In-Reply-To: 
 <CAHC9VhQoawCxVSFGY1whF_pwfH0FHrT7QFC6cgWeFV2XApC6hg@mail.gmail.com>
References: <20260318104322.1643085-1-arnd@kernel.org>
 <CAHC9VhQoawCxVSFGY1whF_pwfH0FHrT7QFC6cgWeFV2XApC6hg@mail.gmail.com>
Subject: Re: [PATCH] lsm: export security_mmap_backing_file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026, at 17:29, Paul Moore wrote:
> On Wed, Mar 18, 2026 at 6:43=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:

> Thanks Arnd.  It looks like I'm going to need to respin this patchset
> due to other changes, do you mind if I fold this patch into the
> associated LSM patch when I do that, or would you prefer this as a
> standalone fix? =20

Please fold it into your patch for the next version.

    Arnd
