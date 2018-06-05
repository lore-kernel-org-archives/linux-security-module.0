From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 5 Jun 2018 08:25:42 -0500
Subject: [PATCH v4 0/8] kexec/firmware: support system wide policy
	requiring signatures
In-Reply-To: <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1528121025.3237.116.camel@linux.vnet.ibm.com>
	<CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
	<20180605040920.GA19747@mail.hallyn.com>
	<CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
Message-ID: <20180605132542.GA26722@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Kees Cook (keescook at chromium.org):
> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> > enough about it to keep bikeshedding, but since this set already exists,
> > it seems like the way to go.
> 
> And the new hook is "load stuff without a file descriptor"?

Yes.  Load stuff based on my own credentials not those attached
to a file.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
