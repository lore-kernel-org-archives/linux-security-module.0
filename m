Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F106228ECD0;
	Wed,  7 May 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653023; cv=none; b=MMGIreUathDzMCJEMg4exW2NjcMQoMwfx9NAXcne5S5zRY31eeaAhUdgVnJWiFQ3N4KZp62hyc+hkUnPJSgNW2+Dhq/aOU1dQSY9PqHU8BQPsE9ymDGlg3tITf+RSfAT6XCRG5otgvecMnqgOaijxDEh5A47ugX/48ZkVz3zShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653023; c=relaxed/simple;
	bh=1OtswvM6Co7Yb8T/QE0HSRCIPveaM5ZbeBw0/fdtDq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkVMEt0obfVSjlMMXeQzzE+2PNB6/SMJTHChfr+xatmqMtKWbtHoMn7gsywpWAjwQ6Acj0xHSwchDf28QWSfNHefnWl/rFD6eMQUFuq6i8C9tLe25vAc73LdoYWaziDsB2uPaG7G648jEvcdPsofsbkc0Qlv47b56jcJu0Phgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VbQ94yYQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VbQ94yYQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CaT1HWMFj3zHHlMo+8HkDfBz7dAsVc84uXpFA7kOHag=; b=VbQ94yYQInhibfB/A4wuA2hI4J
	Ww3NJMmdfcmeGDtpymLD7mG18YMzl8Np90JicGwrU8lZeZcbAjV1F0Gye07ibIsXJQkuEA956WZgc
	UYpjlAc5zhlKBUvZnbu86Nr51lcQLJ0S+4SD65EoYYG71X+GB3753Kcdl0nJibWhX1Cgk7xSUvxpX
	2J/4FcULy/dRasfXioE1W1o3xbANbnLyyz4v9I7E0QNfuqrZheIEUSWaC45iqIp+Nw3QqF7gcfhse
	l06BWqbPCQCUovdKSKHCADZc1DAsHu1K40+meV2uk9we/idFqIxvBDWJ+K6uaViFvSWYbGCwKz95g
	/YIqFZbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCmEj-00000001ePe-2kA2;
	Wed, 07 May 2025 21:23:29 +0000
Date: Wed, 7 May 2025 22:23:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: alexjlzheng@gmail.com, Fan Wu <wufan@linux.microsoft.com>,
	jmorris@namei.org, serge@hallyn.com, greg@kroah.com,
	chrisw@osdl.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2] securityfs: fix missing of d_delete() in
 securityfs_remove()
Message-ID: <20250507212329.GY2023217@ZenIV>
References: <20250507111204.2585739-1-alexjlzheng@tencent.com>
 <CAHC9VhRx6SUqYHm7Nv6JKVzpANsnt-qPONcVqZh=hXOsWMqDBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRx6SUqYHm7Nv6JKVzpANsnt-qPONcVqZh=hXOsWMqDBA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 07, 2025 at 04:10:11PM -0400, Paul Moore wrote:
> > In addition, securityfs_recursive_remove() avoids this problem by calling
> > __d_drop() directly. As a non-recursive version, it is somewhat strange
> > that securityfs_remove() does not clean up the deleted dentry.
> >
> > Fix this by adding d_delete() in securityfs_remove().
> 
> I wondering why we don't simply replace all instances of
> securityfs_remove() with securityfs_recursive_remove(), or more likely
> just remove the existing securityfs_remove() and rename the
> securityfs_recursive_remove() to securityfs_remove().  Do any existing
> LSMs rely on securityfs_remove() *not* acting recursively?

It's a bit trickier than that (there are interesting issues around
efi_secret_unlink() nonsense, as well as insane refcounting grabbing
two references where only one is needed to pin the damn thing)...
