From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 05 Jun 2018 10:05:49 -0400
Subject: [PATCH v4 0/8] kexec/firmware: support system wide policy
	requiring signatures
In-Reply-To: <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1528121025.3237.116.camel@linux.vnet.ibm.com>
	<CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
	<20180605040920.GA19747@mail.hallyn.com>
	<CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
	<20180605132542.GA26722@mail.hallyn.com>
	<CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
Message-ID: <1528207549.3237.149.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-05 at 06:43 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 6:25 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Kees Cook (keescook at chromium.org):
> >> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> >> > enough about it to keep bikeshedding, but since this set already exists,
> >> > it seems like the way to go.
> >>
> >> And the new hook is "load stuff without a file descriptor"?
> >
> > Yes.  Load stuff based on my own credentials not those attached
> > to a file.
> 
> Okay, I can live with that. :)

Can I get your Ack on the loadpin changes in v4a patch 8/8?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
