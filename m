Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804039;
	b=dF8bb3iuD7NEFgEChboSV5yxquMMPLdK3q4W8zjSGDvIsSWqoCN0avj3Art1zoSELko4
	 t09rBX9EL1Z4J+XlXvgsUBhtTs71/drENcGl4TV1ZXahq0RsMBWSqi+7+NR7zZpsNyOXZ
	 mbGIWCXjy+a92vRuOIdweyyFvzF2A/s4ZQww8rzfpP2Qc4HYJAUfncZnt1Zk4Cw3IHF7V
	 IiHw44VoEfOZlroFlxNl5PsuaPNE/QU0eizDrqWEef5H88ANql9HibKtSMx24cfLWm3q9
	 ZjBmGmFBOs4zft4YBPhBeTXx/Y67aCi2/Z80qC2FwZ0/3/x5FYKolNSYiHH161RG5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804039;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=waMrtApbsCCy32qAngNApj9LYKzRQy59KtMCm1H9c9Y=;
	b=ASbV/UuoiznEE9NCw7GRA5lF4WRphn3lcUZXC0iMMCb5c9w55x4T/pUNEvOZ8glm4V3E
	 WMJuWMHikZSLjqf5PGIVxdMpfjbdejF+69AIjzhMQdYhfjfDzmBx0vnkgqIyXFQeR9YGT
	 jdN7+K7bSE24yBzRkG/IQNP/O6EN8cSanhaQKQxO8JfSZASMGB7fVlMZiyvbEV4P1uVAU
	 6zY7eHYdwW2KZLSTVJAXACNjjyO1b69lQZXewMdnK8iP/eGS9GEdW0A9FozzsXDYaewX+
	 7Aej+iUK/TBCvodGSzuG6963YbvOah2ILV78FYxIMZYt1MFxuGXINQitO99wa/xkjJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="XDm/VdRB";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C523606A31C;
	Fri, 27 Nov 2026 18:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C523606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XDm/VdRB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312A12F;
	Fri, 27 Nov 2026 10:27:15 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87973F86C;
	Fri, 27 Nov 2026 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795804038; bh=ocCdgqyFc3OGeaETJDga9WQCqMZ98ADJdKFQOYIh3uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDm/VdRBNwU6kB4H2HczAmipRcbLx6A9+0SKJUFqbSZBQnv0bejhh+uSefIa/oKyF
	 3hBKMcZMZYt/JiCNEOm9Udgxn3RjRsWUC+axRyFOp2NexWkoX2m/xKVyAIiq4uFJU9
	 wCUTGQwWvQrK5p2hKP76/46lVvm+gbWXkaSp4lIo=
Date: Fri, 27 Nov 2026 18:27:12 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <awnLgFZIhRZENiE4@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127170722.GT246011@ziepe.ca>

[...]
> 
> > +static enum hash_algo cca_guest_attestation_algorithms[] = {
> > +	HASH_ALGO_SHA512,
> > +};
> 
> static const

No. it's a scaling issue since the attestion algorithms could be not
only SHA512 but also SHA256 and SHA384....

[...]

-- 
Sincerely,
Yeoreum Yun
