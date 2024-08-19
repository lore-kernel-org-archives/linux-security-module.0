Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FB1DAC42
	for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097316; cv=none; b=FBcB3zFIgw6/BLh6LMEfqr+mB6aANIcLLddfnp/jh/7uo4FUZB7X7ckzA84LI+NUNVHsWw28gQnmWj/PJdxWXHkCxm6IibeZet8CfkB8U6tAPMYynZfb6YCKlWiwxYobgndZfO0vAp/3Sm0jvo/XNVmQg+EyElRXLtjkWjAhCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097316; c=relaxed/simple;
	bh=tbHoPE0VvmtElKliER9pfKhX6a4EXee9XD9DFCh1owc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQajryuSmHnPP62ZaLW3g7Spy3+kvWrKNFJWpomtecHj65FdRtqT2G+kfWWHYVh0iREDHcNsRWnK+h6TUktqm+0yvdbYZf+41R+/WhVraHBY5arNcf/KQp3la87LELtbQXlDnsXakkjuKOKVVrOyW6YEwfEQE7kUYn/NpC20jOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1RpBJuJh; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1RpBJuJh"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WnjpW1HqnzsCn;
	Mon, 19 Aug 2024 21:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724096947;
	bh=XXYTKUIhmb3g4TO0o6A/cG623xPk3XJMJW789prBuLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1RpBJuJhgnI7yHLSl+S6FB5nssMonj/Q+fYtYrthmDUMFxWm3oQ5PihvcGJ24nf1d
	 A3tOPEWUDWuWuCnGyXm6HlRyppPDbruAIMtkLmWBU+Rd+E69ak+6SP3fASGFvgrhBq
	 aEhcetaxPEMPghLcgWKcwPwN3VgZEa2Y8zml3fF8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WnjpV5BJNz2TR;
	Mon, 19 Aug 2024 21:49:06 +0200 (CEST)
Date: Mon, 19 Aug 2024 21:49:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 5/5] Landlock: Document
 LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI versioning
Message-ID: <20240816.ee2Ahkegooch@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <c70649f74688605f31ab632350ab77d2a4453ab9.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c70649f74688605f31ab632350ab77d2a4453ab9.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 14, 2024 at 12:22:23AM -0600, Tahera Fahimi wrote:
> Introducing LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET as an IPC scoping
> mechanism in Landlock ABI version 6, and updating ruleset_attr,
> Landlock ABI version, and access rights code blocks based on that.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> v8:
> - Improving documentation by specifying differences between scoped and
>   non-scoped domains.
> - Adding review notes of version 7.
> - Update date
> v7:
> - Add "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" explanation to IPC scoping
>   section and updating ABI to version 6.
> - Adding "scoped" attribute to the Access rights section.
> - In current limitation, unnamed sockets are specified as sockets that
>   are not restricted.
> - Update date
> ---
>  Documentation/userspace-api/landlock.rst | 33 ++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 07b63aec56fa..0582f93bd952 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: April 2024
> +:Date: July 2024

"August"

Please rebase the two patch series on v6.11-rc4
