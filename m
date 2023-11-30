Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HrYyBBIB"
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17FD6C
	for <linux-security-module@vger.kernel.org>; Thu, 30 Nov 2023 01:18:00 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrFf4bjHzMq0WS;
	Thu, 30 Nov 2023 09:17:58 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrFd4pzQzMppB7;
	Thu, 30 Nov 2023 10:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701335878;
	bh=G329RwiZLc3z7CDo3/S9871ZQCwvPA26TsTzn6uzrHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrYyBBIBzzCT8nx1go6HcLpht8SNTH4IaVcZoHn/kq1V0Mg7Wwdeixim7Q3e49YDC
	 RqAVSW10gnBgsO0Kb74NtDoLrUnzcKRFbX6lmcgRBXZ620uHVl9INFLHozxmhoqX8e
	 wW4Y/hhtCbPVYtcYMkPIhHBSKpg90/2hRjRVXWZs=
Date: Thu, 30 Nov 2023 10:17:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Add tests to check unhandled
 rule's access rights
Message-ID: <20231130.utaiDie8wuov@digikod.net>
References: <20231120193914.441117-1-mic@digikod.net>
 <20231120193914.441117-3-mic@digikod.net>
 <ZWDZlGhDmzeUjBvK@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWDZlGhDmzeUjBvK@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 24, 2023 at 06:12:52PM +0100, Günther Noack wrote:
> On Mon, Nov 20, 2023 at 08:39:14PM +0100, Mickaël Salaün wrote:
> > Add two tests to make sure that we cannot add a rule to a ruleset if the
> > rule's access rights that are not handled by the ruleset:
> > * fs: layout1.rule_with_unhandled_access
> > * net: mini.rule_with_unhandled_access
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c  | 35 +++++++++++++++++++++
> >  tools/testing/selftests/landlock/net_test.c | 33 +++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index d77155d75de5..8cabcbe3554e 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -596,6 +596,41 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
> >  	ASSERT_EQ(0, close(ruleset_fd));
> >  }
> >  
> > +TEST_F_FORK(layout1, rule_with_unhandled_access)
> > +{
> > +	struct landlock_ruleset_attr ruleset_attr = {
> > +		/* First bit */
> > +		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
> 
> Optional nit: If you want to spell out that this is 1, you could as well add an
> assertion for that.  Doesn't even need to be a static_assert, it's just a test
> after all.  Or maybe even put a literal 1 here instead. :)

I'll remove this comment because it is not relevant anymore because the
loop check the related value.

> 
> > +	};
> > +	struct landlock_path_beneath_attr path_beneath = {};
> > +	int ruleset_fd;
> > +	__u64 access;
> > +
> > +	ruleset_fd =
> > +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> > +	ASSERT_LE(0, ruleset_fd);
> > +
> > +	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
> > +	ASSERT_LE(0, path_beneath.parent_fd);
> > +
> > +	for (access = 1; access > 0; access <<= 1) {
> > +		int err;
> > +
> > +		path_beneath.allowed_access = access;
> > +		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> > +					&path_beneath, 0);
> > +		if (access == ruleset_attr.handled_access_fs) {
> > +			EXPECT_EQ(0, err);
> > +		} else {
> > +			EXPECT_EQ(-1, err);
> > +			EXPECT_EQ(EINVAL, errno);
> > +		}
> > +	}
> > +
> > +	EXPECT_EQ(0, close(path_beneath.parent_fd));
> > +	EXPECT_EQ(0, close(ruleset_fd));
> > +}
> > +
> >  TEST_F_FORK(layout0, unknown_access_rights)
> >  {
> >  	__u64 access_mask;
> > diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> > index 9356f5800e31..aec01917abd5 100644
> > --- a/tools/testing/selftests/landlock/net_test.c
> > +++ b/tools/testing/selftests/landlock/net_test.c
> > @@ -1262,6 +1262,39 @@ TEST_F(mini, network_access_rights)
> >  	EXPECT_EQ(0, close(ruleset_fd));
> >  }
> >  
> > +TEST_F(mini, rule_with_unhandled_access)
> > +{
> > +	struct landlock_ruleset_attr ruleset_attr = {
> > +		/* First bit */
> > +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
> 
> Ditto.
> 
> > +	};
> > +	struct landlock_net_port_attr net_port = {
> > +		.port = sock_port_start,
> > +	};
> > +	int ruleset_fd;
> > +	__u64 access;
> > +
> > +	ruleset_fd =
> > +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> > +	ASSERT_LE(0, ruleset_fd);
> > +
> > +	for (access = 1; access > 0; access <<= 1) {
> > +		int err;
> > +
> > +		net_port.allowed_access = access;
> > +		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> > +					&net_port, 0);
> > +		if (access == ruleset_attr.handled_access_net) {
> > +			EXPECT_EQ(0, err);
> > +		} else {
> > +			EXPECT_EQ(-1, err);
> > +			EXPECT_EQ(EINVAL, errno);
> > +		}
> > +	}
> > +
> > +	EXPECT_EQ(0, close(ruleset_fd));
> > +}
> > +
> >  /* Checks invalid attribute, out of landlock network access range. */
> >  TEST_F(mini, unknown_access_rights)
> >  {
> > -- 
> > 2.42.1
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Thanks for the tests!
> —Günther
> 
