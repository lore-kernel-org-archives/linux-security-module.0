Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC032C0283
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796413; cv=none; b=pj1dDIV9mWV3J/qC6+V9eLtiAjx3zqmE5Bu/39paYRvW3uQw/sixF1csa3mtvLB7lp4IN85dQGZ867kRa0olYN29izbOqL/xjWXnU/w7litw6iD4qWv63XerERExoxoElxgj4gZZ1LN0pM00t3tk5tnVdZ91mqSVHhySWkcRvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796413; c=relaxed/simple;
	bh=0vZgYNt8PnHDX7UamoY0vj/ITqoz17oQ0D5RTlObVuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmXwnzQXhQ8Bl7MTc33o09KOJrFUXfcMVpoAK/3Tv/SLF1eAp1xefHYGVK6qaC+ccUfO5/KZXd/D+fMIANx/T1ATGf/EU0JFu2Z4yCUb3rO6ZkMvg0KOvC0tvO28oX7R+/LmlZIQsSqvvDwEm2MD0jli33c6h43Zgoa4v/GDnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=lSfFn8YS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jn97IMH/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="lSfFn8YS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jn97IMH/"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 36382EC05AA;
	Wed,  3 Dec 2025 16:13:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 03 Dec 2025 16:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764796410;
	 x=1764882810; bh=jegMKPR/hZRGTsKtpnTfvnf6LyySKSjKpuL7VCm4eto=; b=
	lSfFn8YSJ8ew/Mk85FepyJVBJPbkf6EOgkejTVc8cvgbInXlhB2YM6a0WT1zW6js
	887gsuMDliOkBPRbndEgQ+/ld25xUbFJRBOzXxwI6edkWUNQ+rICJOJOy4TGdXhx
	w8bNXD7Pa5rZJsKolF6WgNvxr3iz9Jf5MrlV6H9uWDnvXkknOCxSi/nVjNnaMSNE
	7NVbo3C0EtaOKNAkYrIzqVUusFMCohLmdHzOzpqS+/6J5y2R7P6dEE2sMToyWyT5
	AUk1HuaU3uJVt/aKjexqU9psEPB5b9lAcAnyGCCiN49kjziBVZYWAKQ3s1X9hvZh
	q15xL74e3cSsWC1eIlK65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764796410; x=
	1764882810; bh=jegMKPR/hZRGTsKtpnTfvnf6LyySKSjKpuL7VCm4eto=; b=J
	n97IMH/4V8hH1pbqQHzqfPmLmOSCho68zfmRceB7f86EVcUbdgy7xyYqkZFEHn4J
	BimLHz9ckwwqteWkqmgsvUEJ6e+qcDhw2JHwF9/RtMQ2y6hzYFz9yfC4deW1R6tr
	1EE5vqIeUNLzugbCu4w/Rp2t1C6kmDHeud1EqK4isNpyv3ATQSNViW87VN6xkzwG
	TZQXYXydaUu3KiS9NvUOzZtX7v4FcqoP+iVJ6Yg3WYx4c5+xs8KYC6Ou0GUUwQGg
	KFCsttvrWvfJlGF+TuTOtz35YRzwYryXLVEv6jlf39xk9KrAZm9FzZxn4PKnauOu
	MD/Iy9gmRXwSUEUsgcprQ==
X-ME-Sender: <xms:-qcwaQenIu-9fnFPruZxVKfvZ1wSD_6_ztnderoxKqREnEZqp2T9FA>
    <xme:-qcwaV6ptvdn4ON18bkoLjAwJBqQoR7vvLK9c4G0lpAnbHi8xw_vSAdNmU-GwiYrP
    GJja0bDSLb-vFjS36OMmrUSgny7xugLpOK4GvZODRvZGzWyGc8a7w>
X-ME-Received: <xmr:-qcwabXrW4RsTM3ABsyRnYtRYVXK78ytRhQiUOYerw10rbnblO_Hh0xmyEqPOYX8LVz0jAMb52R5iYGLoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfedvhe
    eluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtg
    hksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgt
    phhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-qcwac5psRUz-K_menQkckPEQQpyLDgMGuH3Ac8hoHlv16NsCajYLA>
    <xmx:-qcwaerv9jUh3lHA_TnmqPn6wSuQJcUNBoRWISubsWceTFBLXYjvJQ>
    <xmx:-qcwaXmBmHxJwaZvB0If8G0iNWS2dqGkzctMLTyvpNpAnJkp35jtUA>
    <xmx:-qcwaSNN1mjdS9IupuOKCHVNXJiQpC8e-_DIYdV8VyeSM9N8UVpyOw>
    <xmx:-qcwaRgpEovFZlEXRVV91iCcZNLTnnHzaxEZXesAXDRVZR97uMO1YuGj>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:13:29 -0500 (EST)
Message-ID: <664b4f51-afaa-4dbf-a83f-95a2167eeedb@maowtm.org>
Date: Wed, 3 Dec 2025 21:13:28 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT
 to landlock-sandboxer
To: Justin Suess <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>
References: <20251126122039.3832162-1-utilityemal77@gmail.com>
 <20251126122039.3832162-4-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251126122039.3832162-4-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 12:20, Justin Suess wrote:
> Adds support to landlock-sandboxer with environment variables LL_FS_RO_NO_INHERIT
> and LL_FS_RW_NO_INHERIT. These create the same rulesets as their non-no inherit variants,
> plus the LANDLOCK_ADD_RULE_NO_INHERIT flag.
> 
> v2..v3 changes:
> 
>   * Minor formatting fixes
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  samples/landlock/sandboxer.c | 37 +++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 2d8e3e94b77b..6f6bfc4e5110 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -58,6 +58,8 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  
>  #define ENV_FS_RO_NAME "LL_FS_RO"
>  #define ENV_FS_RW_NAME "LL_FS_RW"
> +#define ENV_FS_RO_NO_INHERIT_NAME "LL_FS_RO_NO_INHERIT"
> +#define ENV_FS_RW_NO_INHERIT_NAME "LL_FS_RW_NO_INHERIT"
>  #define ENV_FS_QUIET_NAME "LL_FS_QUIET"
>  #define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
> @@ -121,7 +123,8 @@ static int parse_path(char *env_path, const char ***const path_list)
>  /* clang-format on */
>  
>  static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
> -			       const __u64 allowed_access, bool quiet)
> +		       const __u64 allowed_access,
> +		       __u32 add_rule_flags, bool mandatory)
>  {
>  	int num_paths, i, ret = 1;
>  	char *env_path_name;
> @@ -132,9 +135,13 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  
>  	env_path_name = getenv(env_var);
>  	if (!env_path_name) {
> -		/* Prevents users to forget a setting. */
> -		fprintf(stderr, "Missing environment variable %s\n", env_var);
> -		return 1;
> +		if (mandatory) {
> +			/* Prevents from forgetting to set necessary env vars. */
> +			fprintf(stderr, "Missing environment variable %s\n",
> +				env_var);
> +			return 1;
> +		}
> +		return 0;
>  	}
>  	env_path_name = strdup(env_path_name);
>  	unsetenv(env_var);
> @@ -171,8 +178,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  		if (!S_ISDIR(statbuf.st_mode))
>  			path_beneath.allowed_access &= ACCESS_FILE;
>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> -				      &path_beneath,
> -				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
> +			      &path_beneath, add_rule_flags)) {
>  			fprintf(stderr,
>  				"Failed to update the ruleset with \"%s\": %s\n",
>  				path_list[i], strerror(errno));
> @@ -375,6 +381,8 @@ static const char help[] =
>  	"Optional settings (when not set, their associated access check "
>  	"is always allowed, which is different from an empty string which "
>  	"means an empty list):\n"
> +	"* " ENV_FS_RO_NO_INHERIT_NAME ": read-only paths without rule inheritance\n"
> +	"* " ENV_FS_RW_NO_INHERIT_NAME ": read-write paths without rule inheritance\n"

Would it make more sense to just have one LL_FS_NO_INHERIT env rule, that
will attach the "no inherit" flag without necessarily adding any access?

>  	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
>  	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
>  	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
> @@ -596,17 +604,28 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	}
>  
>  	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro,
> -				false)) {
> +			0, true)) {
>  		goto err_close_ruleset;
>  	}
>  	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw,
> +			0, true)) {
> +		goto err_close_ruleset;
> +	}
> +	/* Optional no-inherit rules mirror the regular read-only/read-write sets. */
> +	if (populate_ruleset_fs(ENV_FS_RO_NO_INHERIT_NAME, ruleset_fd,
> +				access_fs_ro, LANDLOCK_ADD_RULE_NO_INHERIT,
> +				false)) {
> +		goto err_close_ruleset;
> +	}
> +	if (populate_ruleset_fs(ENV_FS_RW_NO_INHERIT_NAME, ruleset_fd,
> +				access_fs_rw, LANDLOCK_ADD_RULE_NO_INHERIT,

These need to be under an ABI version check like the quiet one - this
sandboxer is designed to "downgrade" what it tries to do gracefully if
running on older kernel.

However, there is an argument that maybe if deny rules aren't supported in
the current running kernel, it should just refuse to run the program at
all, otherwise by running the sandboxed program without the deny rules it
might expose the user to risks they might mitigate via some other means.
But in that case we should still have a better error message when running
on an older kernel than "Failed to update the ruleset with ...: Invalid
argument"

>  				false)) {
>  		goto err_close_ruleset;
>  	}
>  	/* Don't require this env to be present. */
> -	if (quiet_supported && getenv(ENV_FS_QUIET_NAME)) {
> +	if (quiet_supported) {
>  		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
> -					true)) {
> +				LANDLOCK_ADD_RULE_QUIET, false)) {
>  			goto err_close_ruleset;
>  		}
>  	}

