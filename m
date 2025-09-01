Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937A32C336;
	Mon,  1 Sep 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752204; cv=none; b=lNTuiMPRXlyj5ySizLsM+l+Wkio2aNZG8KY2rdHth2B46ui9w/o9fzE72B/xWeOQ5uqK/Ol11oYiQx5nt3DyVwq/VVoaDIGK0y84pI3Sy8oi+7ELVikNpoQHetoNRRgmpFcIOPC6uqEgXCe3NHjpswqnCHZVjnjFu4xmrgt/c54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752204; c=relaxed/simple;
	bh=BV2QsffPgCcItQbw3iqsgjwnrPEDHIbObuX55WuEqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNkXG4j0N7BV/DZ2wuD+szng+Duf9gU+9p+UlFwKK/Y4yrmMDxspZSslfKMXGhr0+JWHcHt5rpJCXZxDd0yhmR9U+4MKJ5RTNirIdapsBZCvX+ktVkHE0xED2wdeIlV+Bsm/BJktcOHc1bDcXCq4/px9dBEiEFETgTyMyqQZT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz/O2iYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz/O2iYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A233C4CEF0;
	Mon,  1 Sep 2025 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752204;
	bh=BV2QsffPgCcItQbw3iqsgjwnrPEDHIbObuX55WuEqsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iz/O2iYDD67lO+giYrZ7cx1t7PCq1FVSktNTJVdcsNDym0/f4t5xfP1cAgOrfsAvR
	 ufS9Vznj01HBn7XaduqqxCeXQoOAzrZsrfiZyIWbI1NMka0kpUbiLdSP0kFf+4cznU
	 IkvElZ7DR1LhrQgvTLDMgB0sNkFCViihEFHB/V8G4CXAPojr/RC5juylMoLCbjT5xM
	 LwJ235ammDyCRLYqXys9ErfA1gpd9U7ca0T0kwslGRiE/EVZphUgSHi49jwaA15u6u
	 8GGHO1XKfVV30UuIctOl4IwjKaEx5dh8zmIPjReALsOlXW7Nfc+UBcePhzQrhQThFy
	 DeE3DezaERw/A==
Date: Mon, 1 Sep 2025 11:43:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 dsahern@kernel.org, petrm@nvidia.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] ipv4: icmp: Fix source IP derivation in
 presence of VRFs
Message-ID: <20250901114322.3f1ca417@kernel.org>
In-Reply-To: <aLVb-ujDn_KhOt4V@shredder>
References: <20250901083027.183468-1-idosch@nvidia.com>
	<aLVb-ujDn_KhOt4V@shredder>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 11:40:26 +0300 Ido Schimmel wrote:
> Resolution is below. Please let me know if you prefer that I repost next
> week in order to avoid the conflict.

Yes, please!
-- 
pw-bot: defer
