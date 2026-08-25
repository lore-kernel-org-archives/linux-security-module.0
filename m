Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACD2E06E4;
	Tue, 25 Aug 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667052; cv=none; b=DX584QajOnObxjsVgECVxN1epHybjJZfX2fWrHtbr4J0mOxzNVNsqRjK68frBPZNZ7WVZvyxzi7pwvDie6Ca40vpdQBDAdsTzyJsX3GLgvbjDrOcsPlf+X39M/FoE6hpRCAKSstEaolIDDxVJPdCV4ByBC6QKjh/5lUk1z+uOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667052; c=relaxed/simple;
	bh=NHD2yBZ6sB22hkVHymYwcXEhUEOc8JWXw1fQh2zQzTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV725/OWlOcl8xJU6y3y7lFSS7CY2o5ukiO3Dn+qP0gZwyWjl03LOK3wQ0+UUU+GW/De0aUiX8X8zhUpJQwNP6ezRzYNrZfpVm3P7IiO3xl/apC9qjXXYFVQSKTHEO2hPdVDs1v7FAdnHj6TqT3F01vKCovtR+jaySeIahNKej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=E5PungHK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="E5PungHK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YdPYAT+boZ9/kN51fWnNRwc2bjydxSYXTJ5llYSbpxA=; b=E5PungHK75nQSZY1+LYWf5t1yy
	fcgxX8TNX0Eizl4xJ7oHvRc5FiKfRaqU3svseFHOnTGo2KFe3czfPQ7t2qPwP0YGPMfTXcL6rxF0X
	yXE9AM1oT4mARTaBPtNUiBcyWvpo9a5gUBa4Q8sKXrbpwIW+Bvk1S2Z2tYYgp/Y9WahHBor1zzKJl
	nYPpg6P6Ss5cBQy4wYUZ6BW5ojDYIFHm3w1x4YVtnsrUB9GMgPit2k5fkM/ZX/0tQzarwVW82FgCf
	ZqwyjPBlgixW4Y9pZyT1cNUo0SXtRiFlA3k4oFGYTHVYhh/AZzdoKmSArgyYYnc+4tpoqz10pjRlH
	XEGNmBGA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyrqo-00EUcM-2f;
	Tue, 25 Aug 2026 14:10:07 +0000
Date: Tue, 25 Aug 2026 07:10:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/2] configfs: move CONFIGFS_MAGIC definition to
 magic.h
Message-ID: <ao2iHWDZAJf0FRqh@gmail.com>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
 <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
X-Debian-User: leitao

On Wed, Aug 19, 2026 at 06:45:22PM -0500, Frederick Lawler wrote:
> IMA shouldn't measure or appraise configfs, but currently does because
> it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> magic.h to expose the file system's magic to IMA, as well as other userland
> applications.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Do you want this change to go thorugh the configfs tree, or the tree
specific for IMA?
?
