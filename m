Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85A138
	for <linux-security-module@vger.kernel.org>; Mon, 27 Nov 2023 00:04:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sdyfc4W66z6K67Z;
	Mon, 27 Nov 2023 15:59:36 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (unknown [7.191.163.9])
	by mail.maildlp.com (Postfix) with ESMTPS id BC748140A70;
	Mon, 27 Nov 2023 16:04:04 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Nov 2023 08:04:03 +0000
Message-ID: <b5b268a8-7da4-34b6-978f-9c7a3dcae73f@huawei.com>
Date: Mon, 27 Nov 2023 11:04:02 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v1 2/2] selftests/landlock: Add tests to check unhandled
 rule's access rights
Content-Language: ru
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
	=?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>
CC: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>, "Serge
 E . Hallyn" <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	Artem Kuzin <artem.kuzin@huawei.com>
References: <20231120193914.441117-1-mic@digikod.net>
 <20231120193914.441117-3-mic@digikod.net>
From: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20231120193914.441117-3-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500004.china.huawei.com (7.191.163.9)



11/20/2023 10:39 PM, Mickaël Salaün пишет:
> Add two tests to make sure that we cannot add a rule to a ruleset if the
> rule's access rights that are not handled by the ruleset:
> * fs: layout1.rule_with_unhandled_access
> * net: mini.rule_with_unhandled_access
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>   tools/testing/selftests/landlock/fs_test.c  | 35 +++++++++++++++++++++
>   tools/testing/selftests/landlock/net_test.c | 33 +++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index d77155d75de5..8cabcbe3554e 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -596,6 +596,41 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
>   	ASSERT_EQ(0, close(ruleset_fd));
>   }
>   
> +TEST_F_FORK(layout1, rule_with_unhandled_access)
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		/* First bit */
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
> +	};
> +	struct landlock_path_beneath_attr path_beneath = {};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath.parent_fd);
> +
> +	for (access = 1; access > 0; access <<= 1) {
> +		int err;
> +
> +		path_beneath.allowed_access = access;
> +		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath, 0);
> +		if (access == ruleset_attr.handled_access_fs) {
> +			EXPECT_EQ(0, err);
> +		} else {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EINVAL, errno);
> +		}
> +	}
> +
> +	EXPECT_EQ(0, close(path_beneath.parent_fd));
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>   TEST_F_FORK(layout0, unknown_access_rights)
>   {
>   	__u64 access_mask;
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 9356f5800e31..aec01917abd5 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1262,6 +1262,39 @@ TEST_F(mini, network_access_rights)
>   	EXPECT_EQ(0, close(ruleset_fd));
>   }
>   
> +TEST_F(mini, rule_with_unhandled_access)
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		/* First bit */
> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
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
> +	for (access = 1; access > 0; access <<= 1) {
> +		int err;
> +
> +		net_port.allowed_access = access;
> +		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +					&net_port, 0);
> +		if (access == ruleset_attr.handled_access_net) {
> +			EXPECT_EQ(0, err);
> +		} else {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EINVAL, errno);
> +		}
> +	}

    We have such kind of check in TEST_f(mini, inval). Can you please 
explain why we need additional one here?
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>   /* Checks invalid attribute, out of landlock network access range. */
>   TEST_F(mini, unknown_access_rights)
>   {
