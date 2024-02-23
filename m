Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0640146E6C
	for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718652; cv=none; b=J9SO5R+E0Vq+6LrlK/jlAGmB7zpafyL8r4jvwsubWZYjtKXRUO2W77IPUU+/FUSvNHKa8s6HIsmPnqA8+4nHcnrlpqXlNu7A/zA4/Bqd1BG+492tU/LT4d3QWm79ft/0Gm4OqJK0/Jlzfd5ZMDvY1/fXnBs7dwihDD5lrcSwX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718652; c=relaxed/simple;
	bh=9cEDsIi8vRUs821xVTfotIwh6nb7wOR2IdPnx9HNDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVpEtL+m+0PnlRam1SXp8AUYAB7LCoe62PvRvJ3qdU9Cjf1rvTTWMl/acrIgN7GTqlkwtJa7iSuFkQ3Jg5rLdpmmIkGZVxFVh/VLvSo2Jlgyk+7q7eBtnSo/1kU+IPVx2kjL1hO9lBGuP0hgd+r7pzb55ZApr5J3+MMWdCklfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JfknjjIn; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JfknjjIn"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThLYs49M6zDVP;
	Fri, 23 Feb 2024 21:04:01 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThLYs1CxQzqSX;
	Fri, 23 Feb 2024 21:04:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708718641;
	bh=9cEDsIi8vRUs821xVTfotIwh6nb7wOR2IdPnx9HNDH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfknjjInQug3qdZGhwqvNpZPx7gaVjnaWd8pJ7emv2KpVxsH4x/UtqnHs+8NFJgDj
	 WchxVjpycDUWTgmHLsTCbSbvJKPyyTAQ86rBp71J+/DZcFdqgTZayz1gju40xLYBzz
	 D+Xs0yJQOSkkMyQ7o4btN9r19WF4Ci7mUOTZ0sMM=
Date: Fri, 23 Feb 2024 21:03:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Message-ID: <20240223.eij0Oudai0Ia@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
 <20240223.ieSh2aegurig@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223.ieSh2aegurig@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 08:59:34PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 23, 2024 at 08:05:45PM +0100, Mickaël Salaün wrote:
> > selinux_lsm_getattr() may not initialize the value's pointer in some
> > case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
> > selinux_getselfattr() to avoid an UAF in the kfree() call.
> 
> Not UAF but NULL pointer dereference (both patches)...

Well, that may be the result (as observed with the kfree() call), but
the cause is obviously an uninitialized pointer.
