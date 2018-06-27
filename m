From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 28 Jun 2018 00:42:34 +0300
Subject: [PATCH] proc: save 2 atomic ops on write to "/proc/*/attr/*"
In-Reply-To: <20180627200218.GF18113@avx2>
References: <20180627200218.GF18113@avx2>
Message-ID: <CAHp75Vcp61v_VeMNrKYwpc7MKXy2Mjcx9kek-oPyX8A+P7ci1w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 27, 2018 at 11:02 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Code checks if write is done by current to its own attributes.
> For that get/put pair is unnecessary as it can be done under RCU.

>         /* No partial writes. */
> -       length = -EINVAL;
>         if (*ppos != 0)
> -               goto out;
> +               return -EINVAL;
>
>         page = memdup_user(buf, count);
>         if (IS_ERR(page)) {

> -               length = PTR_ERR(page);
> +               rv = PTR_ERR(page);
>                 goto out;

You alredy have more than one exit location, why not to convert this
one as well and get rid of out label completely?

>         }

>  out_free:
>         kfree(page);
>  out:

> +       return rv;
>  }

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
