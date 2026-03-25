Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCE17BED0;
	Wed, 25 Mar 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441969; cv=none; b=dN2cmZPCaICiAtrSrwt8XqSlYnypprsYv3ZaKfZr0sOCgBXTx+sgne8Nt/XYe+khPK5aa5oH+4i+JFkpvqgA4QqkK0EToWJ8/4iqJmqAm0CJiI143aXtOaLp0NkdNaUX+HzyjEL0cUdemfwKg5q2hUH72TevzeW8PaTXaqzoQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441969; c=relaxed/simple;
	bh=0yBpvRHW4fELo9QzuOidLm+ngg+1tVEK4yr9sP3XXW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDE84VAFqJpuezY7Y2oEEo3RIsnaEGhwl1d7LBjSL4kpT1igzvEbPtnXKvyfy7hDgTUz5MWNyav7EYLIYWgPxrd8kIgxW2nvSuDRH9L9FQZH1Rxzm/EqSa+F3tPlyz/f3MUJ04WFEBkl7eIRKu5iUdH+jESD0gKZuBZxVc0GgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXn+5l9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXn+5l9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC1DC4CEF7;
	Wed, 25 Mar 2026 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774441968;
	bh=0yBpvRHW4fELo9QzuOidLm+ngg+1tVEK4yr9sP3XXW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXn+5l9qByPqULQZRTOWWC5DYpCbQ56cd/fq+2rVoaAhg3Yv5yd06ipShv4TBvNgZ
	 MoWIciRKTIRp3c6/PVRH53jIgqTGaKtIbNngNKP78KekYH1gcjJ1D/0t62RZw13vRz
	 ZBzTuqnuGSzC3NStW2rMoQqI3PJWWB3ONVKvBNO83Bl5U8cmZiBb9fxZYTFixhshVr
	 7BPZwzmGeR1+Nvw1Z5ff4Esm+iXsTi4Bdtt3reStgiz4dn2Y1Nc9b5F7Td7zgmlrvn
	 prrB2T+OQkOn5iE3wUFRNLQkK2K0ZreVwgcTQ0aOZBJkSl7x65hY0Ij5shIxIJ4vkL
	 VasMtrlWj+XqQ==
Date: Wed, 25 Mar 2026 13:32:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/11] security: Add LSM_AUDIT_DATA_NS for
 namespace audit records
Message-ID: <20260325-fachgebiet-parzelle-8ae15e6f305f@brauner>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-3-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:35AM +0100, Mickaël Salaün wrote:
> Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> information in audit records.  Two fields are provided, matching the
> field names of struct ns_common:
> 
> - ns_type: the CLONE_NEW* flag identifying the namespace type, logged in
>   hexadecimal.
> 
> - inum: the proc inode number identifying a specific namespace instance.
>   Namespace inode numbers are allocated by proc_alloc_inum() via
>   ida_alloc_max() bounded to UINT_MAX, so the value always fits in 32
>   bits.
> 
> A new audit data type is needed because no existing LSM_AUDIT_DATA_*
> type carries namespace information.  The closest alternatives (e.g.
> LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
> either lose the namespace type or require ad-hoc formatting that
> bypasses the structured audit data union.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h | 5 +++++
>  security/lsm_audit.c      | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 382c56a97bba..6e20a56b8c22 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -78,6 +78,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_NOTIFICATION 16
>  #define LSM_AUDIT_DATA_ANONINODE	17
>  #define LSM_AUDIT_DATA_NLMSGTYPE	18
> +#define LSM_AUDIT_DATA_NS		19
>  	union 	{
>  		struct path path;
>  		struct dentry *dentry;
> @@ -100,6 +101,10 @@ struct common_audit_data {
>  		int reason;
>  		const char *anonclass;
>  		u16 nlmsg_type;
> +		struct {
> +			u32 ns_type;
> +			unsigned int inum;

fwiw, you might want to start the 64-bit namespace id as well.
But either way:

Reviewed-by: Christian Brauner <brauner@kernel.org>
