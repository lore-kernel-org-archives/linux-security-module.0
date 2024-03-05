Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E5127B67
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654433; cv=none; b=h2M8ppJCZCmJ7rglkUowzgNMnEamVSytO/B2SHdwewrnffcPwNwEFCKajrQjEkrw+Pit8uy7pH5ze82cSByugPre66dJci3VfsvIBSohJSTwpmLEd53XtbEbyLVI32qjolLt1+RcXQZ1fpJIBWOdRNYm5JAeYOc4QGLC4/6ox+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654433; c=relaxed/simple;
	bh=ue1Fg+6PAqeVbOLBaqzgadL3cQSFzw3F6sfDg+/iUjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaZC5PINBZ7HsnHskJeqzIrEDo95mn1Y421mmD1BpcLik8B+H0EQZ0RGdQl2I8wqxg1QGvjzPAC6KbwNZ9gn/hTtBUM735zh4mAj3I1ef4wwEBxfu4L6skCOu4Vz5i0KQhmgqrOXS8Bwe2tsBh4dl1LDmbj7FnMSianGIRFtSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UM0OUMbD; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UM0OUMbD"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq0dg1KBBzMpvMw;
	Tue,  5 Mar 2024 17:00:23 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq0df3wLszvr;
	Tue,  5 Mar 2024 17:00:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709654423;
	bh=ue1Fg+6PAqeVbOLBaqzgadL3cQSFzw3F6sfDg+/iUjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM0OUMbDmXkdN+AYlV1EP4YMfYfg/egqSlGrg+qTLzMJgsR4MEAJSTbR7Kft66jfE
	 6pHppjeZpswTIUFhpIgYTJPW/x+5+GzAeGlxg9h6UDp19uR/7kUCdzTdrECBGD5B8f
	 XE7TxtP61ZB7DlmrSDR/YJBon634mqZcEfSOE99M=
Date: Tue, 5 Mar 2024 17:00:11 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	keescook@chromium.org, davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240305.hoi8ja1eeg4C@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <7bb3b635-9fed-47ab-a640-ccac6d283b54@intel.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bb3b635-9fed-47ab-a640-ccac6d283b54@intel.com>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 04:48:06PM +0100, Przemek Kitszel wrote:
> On 3/5/24 00:04, Jakub Kicinski wrote:
> > On Mon, 4 Mar 2024 22:20:03 +0000 Mark Brown wrote:
> > > On Wed, Feb 28, 2024 at 04:59:07PM -0800, Jakub Kicinski wrote:
> > > 
> > > > When running selftests for our subsystem in our CI we'd like all
> > > > tests to pass. Currently some tests use SKIP for cases they
> > > > expect to fail, because the kselftest_harness limits the return
> > > > codes to pass/fail/skip. XFAIL which would be a great match
> > > > here cannot be used.
> > > > 
> > > > Remove the no_print handling and use vfork() to run the test in
> > > > a different process than the setup. This way we don't need to
> > > > pass "failing step" via the exit code. Further clean up the exit
> > > > codes so that we can use all KSFT_* values. Rewrite the result
> > > > printing to make handling XFAIL/XPASS easier. Support tests
> > > > declaring combinations of fixture + variant they expect to fail.
> > > 
> > > This series landed in -next today and has caused breakage on all
> > > platforms in the ALSA pcmtest-driver test.  When run on systems that
> > > don't have the driver it needs loaded the test skip but since this
> > > series was merged skipped tests are logged but then reported back as
> > > failures:
> > > 
> > > # selftests: alsa: test-pcmtest-driver
> > > # TAP version 13
> > > # 1..5
> > > # # Starting 5 tests from 1 test cases.
> > > # #  RUN           pcmtest.playback ...
> > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > # # playback: Test failed
> > > # #          FAIL  pcmtest.playback
> > > # not ok 1 pcmtest.playback #  Can't read patterns. Probably, module isn't loaded
> > > # #  RUN           pcmtest.capture ...
> > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > # # capture: Test failed
> > > # #          FAIL  pcmtest.capture
> > > # not ok 2 pcmtest.capture #  Can't read patterns. Probably, module isn't loaded
> > > # #  RUN           pcmtest.ni_capture ...
> > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > # # ni_capture: Test failed
> > > # #          FAIL  pcmtest.ni_capture
> > > # not ok 3 pcmtest.ni_capture #  Can't read patterns. Probably, module isn't loaded
> > > # #  RUN           pcmtest.ni_playback ...
> > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > # # ni_playback: Test failed
> > > # #          FAIL  pcmtest.ni_playback
> > > # not ok 4 pcmtest.ni_playback #  Can't read patterns. Probably, module isn't loaded
> > > # #  RUN           pcmtest.reset_ioctl ...
> > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > # # reset_ioctl: Test failed
> > > # #          FAIL  pcmtest.reset_ioctl
> > > # not ok 5 pcmtest.reset_ioctl #  Can't read patterns. Probably, module isn't loaded
> > > # # FAILED: 0 / 5 tests passed.
> > > # # Totals: pass:0 fail:5 xfail:0 xpass:0 skip:0 error:0
> > > 
> > > I haven't completely isolated the issue due to some other breakage
> > > that's making it harder that it should be to test.
> > > 
> > > A sample full log can be seen at:
> > > 
> > >     https://lava.sirena.org.uk/scheduler/job/659576#L1349
> > 
> > Thanks! the exit() inside the skip evaded my grep, I'm testing this:
> > 
> > diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> > index a52ecd43dbe3..7ab81d6f9e05 100644
> > --- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
> > +++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> > @@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
> >   	int err;
> >   	if (geteuid())
> > -		SKIP(exit(-1), "This test needs root to run!");
> > +		SKIP(exit(KSFT_SKIP), "This test needs root to run!");
> >   	err = read_patterns();
> >   	if (err)
> > -		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
> > +		SKIP(exit(KSFT_SKIP), "Can't read patterns. Probably, module isn't loaded");
> >   	card_name = malloc(127);
> >   	ASSERT_NE(card_name, NULL);
> > diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> > index 20294553a5dd..356ba5f3b68c 100644
> > --- a/tools/testing/selftests/mm/hmm-tests.c
> > +++ b/tools/testing/selftests/mm/hmm-tests.c
> > @@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
> >   	self->fd = hmm_open(variant->device_number);
> >   	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
> > -		SKIP(exit(0), "DEVICE_COHERENT not available");
> > +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
> >   	ASSERT_GE(self->fd, 0);
> >   }
> > @@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
> >   	self->fd0 = hmm_open(variant->device_number0);
> >   	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
> > -		SKIP(exit(0), "DEVICE_COHERENT not available");
> > +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
> >   	ASSERT_GE(self->fd0, 0);
> >   	self->fd1 = hmm_open(variant->device_number1);
> >   	ASSERT_GE(self->fd1, 0);
> > 
> > > but there's no more context.  I'm also seeing some breakage in the
> > > seccomp selftests which also use kselftest-harness:
> > > 
> > > # #  RUN           TRAP.dfl ...
> > > # # dfl: Test exited normally instead of by signal (code: 0)
> > > # #          FAIL  TRAP.dfl
> > > # not ok 56 TRAP.dfl
> > > # #  RUN           TRAP.ign ...
> > > # # ign: Test exited normally instead of by signal (code: 0)
> > > # #          FAIL  TRAP.ign
> > > # not ok 57 TRAP.ign
> > 
> > Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> > child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.
> > 
> 
> Hi, sorry for not trying to reproduce it locally and still commenting,
> but my vfork() man page says:
> 
> | The child must  not  return  from  the current  function  or  call
> | exit(3) (which would have the effect of calling exit handlers
> | established by the parent process and flushing the parent's stdio(3)
> | buffers), but may call _exit(2).
> 
> And you still have some exit(3) calls.

Correct, exit(3) should be replaced with _exit(2).

> 
> 
> 
