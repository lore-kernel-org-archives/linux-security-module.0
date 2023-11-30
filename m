Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cW3UDZB0"
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D994
	for <linux-security-module@vger.kernel.org>; Thu, 30 Nov 2023 01:17:42 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrFH6dw5zMpng9;
	Thu, 30 Nov 2023 09:17:39 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrFG4D6XzMpnPt;
	Thu, 30 Nov 2023 10:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701335859;
	bh=2Hp/o/2WUTWu8OE3ShLNnGeDrsCDhkl9ipbvp62Eri4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cW3UDZB0bApogVrRaLgF714O91Qddypq/LiCo758YWputHJmFf0YtgPTqPUE5jue0
	 jGs7jN3pXPumeGaKDRCuIbmsfK3mpAtF4mbWlmGsxyzT+R+XmqJtrovHg9BdBmO/pt
	 ty/c0/Ndtg5KzhrAKdVNRHet1+vJO6VvNj3+k1n4=
Date: Thu, 30 Nov 2023 10:17:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/2] selftests/landlock: Add tests to check undefined
 rule's access rights
Message-ID: <20231130.aB1mohx9eika@digikod.net>
References: <20231120193914.441117-1-mic@digikod.net>
 <20231120193914.441117-2-mic@digikod.net>
 <ZWDYOThtJcTx_Z7U@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWDYOThtJcTx_Z7U@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 24, 2023 at 06:07:05PM +0100, Günther Noack wrote:
> On Mon, Nov 20, 2023 at 08:39:13PM +0100, Mickaël Salaün wrote:
> > Extend two tests to make sure that we cannot add a rule with access
> > rights that are undefined:
> > * fs: layout1.file_and_dir_access_rights
> > * net: mini.network_access_rights
> > 
> > The checks test all 64 bits access right values until it overflows.
> > 
> > Replace one ASSERT with EXPECT in layout1.file_and_dir_access_rights .
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c  | 17 ++++++++++++-----
> >  tools/testing/selftests/landlock/net_test.c | 17 ++++++++++-------
> >  2 files changed, 22 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 18e1f86a6234..d77155d75de5 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -548,7 +548,6 @@ TEST_F_FORK(layout1, inval)
> >  TEST_F_FORK(layout1, file_and_dir_access_rights)
> >  {
> >  	__u64 access;
> > -	int err;
> >  	struct landlock_path_beneath_attr path_beneath_file = {},
> >  					  path_beneath_dir = {};
> >  	struct landlock_ruleset_attr ruleset_attr = {
> > @@ -568,11 +567,19 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
> >  		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
> >  	ASSERT_LE(0, path_beneath_dir.parent_fd);
> >  
> > -	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
> > +	for (access = 1; access > 0; access <<= 1) {
> > +		int err;
> > +
> >  		path_beneath_dir.allowed_access = access;
> > -		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
> > -					       LANDLOCK_RULE_PATH_BENEATH,
> > -					       &path_beneath_dir, 0));
> > +		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> > +					&path_beneath_dir, 0);
> > +		if (access <= ACCESS_LAST) {
> > +			EXPECT_EQ(0, err);
> > +		} else {
> > +			EXPECT_EQ(-1, err);
> > +			EXPECT_EQ(EINVAL, errno);
> > +			continue;
> > +		}
> 
> Style question: why not have two loops next to each other?  You could keep the
> old loop from 1 to ACCESS_LAST and then have a separate one from ACCESS_LAST+1
> onwards.  Then you would not need to put logic inside the loop; it might reduce
> nesting a bit, and each loop individually might be slightly easier to grasp.
> 
> I was initially a bit confused why the other landlock_add_rule() call for the
> directory doesn't need the same change. That is clear to me after looking at the
> code a few seconds longer, but it might be slightly simpler with two separate
> loops.

Indeed, I'll send a v2.

> 
> But this is a minor nit.
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Thanks!
> —Günther
> 
