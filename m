From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 05 Jun 2018 18:40:11 -0400
Subject: [PATCH v4a 8/8] module: replace the existing LSM hook in
	init_module
In-Reply-To: <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
	<CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
	<1527635645.3534.39.camel@linux.vnet.ibm.com>
	<CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
	<1527780226.3427.20.camel@linux.vnet.ibm.com>
	<CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
	<1528234513.3557.16.camel@linux.vnet.ibm.com>
	<CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
Message-ID: <1528238411.3557.32.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-05 at 15:26 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 2:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2018-06-05 at 12:45 -0700, Kees Cook wrote:
> >
> >> And if you must have a separate enum, please change this to fail
> >> closed instead of open (and mark the fall-through):
> >>
> >> int rc = -EPERM;
> >>
> >> switch (id) {
> >> case LOADING_MODULE:
> >>     rc = loadpin_read_file(NULL, READING_MODULE);
> >>     /* Fall-through */
> >> default:
> >>     break;
> >> }
> >
> > This will fail the sysfs firmware fallback loading and the kexec_load
> > syscall without any message, as you have for init_module.  Is that
> > what you want?
> 
> I'd prefer there be a full mapping of the enums so that everything
> gets passed into loadpin_read_file() :)
> 
> Can the enum be shared or is that nonsensical?

Considering this is v4 of the patch set, it's pretty obvious I did
everything possible not to define a new LSM hook. ?Even if we can't
re-use the existing enum, we could define the new enum in terms
of?__kernel_read_file_id.

enum kernel_load_data_id {
        __kernel_read_file_id(__data_id_enumify)
};

static const char * const kernel_load_data_str[] = {
        __kernel_read_file_id(__data_id_stringify)
};

Eric, Serge, would using either the existing __kernel_read_file_id
enum or the above definitions be acceptable?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
