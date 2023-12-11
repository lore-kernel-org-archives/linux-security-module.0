Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gk4xaNgp"
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C33D7
	for <linux-security-module@vger.kernel.org>; Sun, 10 Dec 2023 23:18:06 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SpY4D4fW9zMq67b;
	Mon, 11 Dec 2023 07:18:04 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SpY4C3gyDzMpp9q;
	Mon, 11 Dec 2023 08:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1702279084;
	bh=jach5OSwRgP7alXIIYVWdrqLwIsTOCyrWlKh+LHiLdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gk4xaNgp+/WQqXEwzv8p6qwsHmqd3W5k9HTLAvzxkPQFj8RGxCzcfjVmSCyMftT9+
	 dq8F6Ilh3C6HcTDVTnBsUUfV/pfUK/dDUmDJim4skSC8/RFExMdDQjEMJ6NMjTLokw
	 OgckqamvPcy9yUDXDOsa0cjdNxHUkWv/yak3F++8=
Date: Mon, 11 Dec 2023 08:17:57 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/landlock: Add tests to check unknown
 rule's access rights
Message-ID: <20231211.aiJeiKaizai9@digikod.net>
References: <20231130093616.67340-1-mic@digikod.net>
 <20231130093616.67340-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130093616.67340-2-mic@digikod.net>
X-Infomaniak-Routing: alpha

Günther, are you OK with this update?

On Thu, Nov 30, 2023 at 10:36:15AM +0100, Mickaël Salaün wrote:
> Add two tests to make sure that we cannot add a rule with access
> rights that are unknown:
> * fs: layout0.rule_with_unknown_access
> * net: mini.rule_with_unknown_access
> 
> Rename unknown_access_rights tests to ruleset_with_unknown_access .
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> * Move checks into their own test/loop as suggested by Günther Noack.
> * Don't change layout1.file_and_dir_access_rights
> ---
>  tools/testing/selftests/landlock/fs_test.c  | 29 ++++++++++++++++++++-
>  tools/testing/selftests/landlock/net_test.c | 27 ++++++++++++++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18e1f86a6234..1e6c474e3d08 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -589,7 +589,7 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
>  
> -TEST_F_FORK(layout0, unknown_access_rights)
> +TEST_F_FORK(layout0, ruleset_with_unknown_access)
>  {
>  	__u64 access_mask;
>  
> @@ -605,6 +605,33 @@ TEST_F_FORK(layout0, unknown_access_rights)
>  	}
>  }
>  
> +TEST_F_FORK(layout0, rule_with_unknown_access)
> +{
> +	__u64 access;
> +	struct landlock_path_beneath_attr path_beneath = {};
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = ACCESS_ALL,
> +	};
> +	const int ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	path_beneath.parent_fd =
> +		open(TMP_DIR, O_PATH | O_DIRECTORY | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath.parent_fd);
> +
> +	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
> +		path_beneath.allowed_access = access;
> +		EXPECT_EQ(-1, landlock_add_rule(ruleset_fd,
> +						LANDLOCK_RULE_PATH_BENEATH,
> +						&path_beneath, 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +	ASSERT_EQ(0, close(path_beneath.parent_fd));
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  static void add_path_beneath(struct __test_metadata *const _metadata,
>  			     const int ruleset_fd, const __u64 allowed_access,
>  			     const char *const path)
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 929e21c4db05..83d9abc3ee55 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1260,7 +1260,7 @@ TEST_F(mini, network_access_rights)
>  }
>  
>  /* Checks invalid attribute, out of landlock network access range. */
> -TEST_F(mini, unknown_access_rights)
> +TEST_F(mini, ruleset_with_unknown_access)
>  {
>  	__u64 access_mask;
>  
> @@ -1276,6 +1276,31 @@ TEST_F(mini, unknown_access_rights)
>  	}
>  }
>  
> +TEST_F(mini, rule_with_unknown_access)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = ACCESS_ALL,
> +	};
> +	struct landlock_net_port_attr net_port = {
> +		.port = sock_port_start,
> +	};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
> +		net_port.allowed_access = access;
> +		EXPECT_EQ(-1,
> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +					    &net_port, 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_F(mini, inval)
>  {
>  	const struct landlock_ruleset_attr ruleset_attr = {
> -- 
> 2.42.1
> 
> 
